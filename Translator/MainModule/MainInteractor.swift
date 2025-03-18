//
//  MainInteractor.swift
//  Translator
//
//  Created by Ксения Маричева on 28.01.2025.
//

import Foundation

protocol MainInteractorProtocol: AnyObject{
    func translate(_ text: String)
    func viewDidLoaded()
    func sourceLanguageSelected()
    func targetLanguageSelected()
    func switchTapped()
}

class MainInteractor {
    
    weak var presenter: MainPresenterProtocol?
    
    var selectedLanguages: SelectedLanguages = (.en, .ru)
    
    lazy var languagesSelected: (SelectedLanguages) -> Void = { [weak self] selectedLanguages in
        guard let self else { return }
        self.selectedLanguages = selectedLanguages
        self.presenter?.setLanguages(selectedLanguages)
    }
    
    func translateText(_ text: String,
                       completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = URL(string: "https://translate.api.cloud.yandex.net/translate/v2/translate")!
        
        let rawValue = YTModel(sourceLanguageCode: selectedLanguages.source.rawValue, targetLanguageCode: selectedLanguages.target.rawValue, texts: [text])
        let requestBody = try? JSONEncoder().encode(rawValue)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization": "Api-Key AQVNyfAT_T2hLmyZGljnx0FtgWeMbgdH4iprR2lD"]
        request.httpBody = requestBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(APIError.serverError))
                return
            }
            
            guard let data else {
                completion(.failure(APIError.badData))
                return
            }
            
            do {
                completion(.success((try JSONDecoder().decode(YTranslateResponse.self, from: data)).translations[0].text))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
}

extension MainInteractor: MainInteractorProtocol {
    
    func viewDidLoaded() {
        presenter?.setLanguages(selectedLanguages)
    }
    
    func translate(_ text: String) {
        translateText(text) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let translation):
                    CoreDataManager.shared.saveTranslation(original: text, translation: translation, languages: self.selectedLanguages)
                    self.presenter?.didTranslate(text: translation)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func sourceLanguageSelected() {
        presenter?.presentLanguagesController(selectedLanguages, destination: .source, languagesSelected: languagesSelected)
    }
    
    func targetLanguageSelected() {
        presenter?.presentLanguagesController(selectedLanguages, destination: .target, languagesSelected: languagesSelected)
    }
    
    func switchTapped() {
        selectedLanguages = (selectedLanguages.target, selectedLanguages.source)
        presenter?.setLanguages(selectedLanguages)
    }
}
