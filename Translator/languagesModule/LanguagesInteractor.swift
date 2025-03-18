//
//  LanguagesInteractor.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import Foundation

protocol LanguagesInteractorProtocol: AnyObject {
    func viewDidLoaded()
    func didSelectRowAt(_ index: Int)
}

class LanguagesInteractor {
    
    weak var presenter: LanguagesPresenterProtocol?

    let destination: DestinationLanguage
    var selectedLanguages: SelectedLanguages
    
    var languages: [Language] = [ .ru, .en, .es]
    
    init(selectedLanguages: SelectedLanguages, destination: DestinationLanguage) {
        self.selectedLanguages = selectedLanguages
        self.destination = destination
    }
    
    #warning("Добавила функцию которая меняет местами параметры")
    private func switchLanguages() {
        selectedLanguages = (selectedLanguages.target, selectedLanguages.source)
    }
}

extension LanguagesInteractor: LanguagesInteractorProtocol {
    
    func viewDidLoaded() {
        #warning("Добавила проверку на то какой язык выбраный")
        let selecdedLanguage: Language
        switch destination {
        case.source:
            selecdedLanguage = selectedLanguages.source
        case .target:
            selecdedLanguage = selectedLanguages.target
        }
        presenter?.setLanguages(languages, header: destination.header, selecdedLanguage: selecdedLanguage)
    }
    
    func didSelectRowAt(_ index: Int) {
        
        switch destination {
        case .source:
            #warning("Добавила проверку совпадает ли выбраный элемент с противополжным, если да то значения меняются местами")
            if selectedLanguages.target == languages[index] {
                switchLanguages()
            }
            selectedLanguages.source = languages[index]
        case .target:
            #warning("Добавила проверку совпадает ли выбраный элемент с противополжным, если да то значения меняются местами")
            if selectedLanguages.source == languages[index] {
                switchLanguages()
            }
            selectedLanguages.target = languages[index]
        }
        
        presenter?.changeSelectedLanguages(selectedLanguages)
    }
}
