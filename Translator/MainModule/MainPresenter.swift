//
//  MainPresenter.swift
//  Translator
//
//  Created by Ксения Маричева on 28.01.2025.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func enterButtonTapped(text: String?)
    func didTranslate(text: String)
    func sourceLanguageSelected()
    func targetLanguageSelected()
    func setLanguages(_ languages: SelectedLanguages)
    func viewDidLoaded()
    func presentLanguagesController(_ languages: SelectedLanguages, destination: DestinationLanguage, languagesSelected: @escaping (SelectedLanguages) -> Void)
    func switchTapped()
}

class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol
    
    init(router: MainRouterProtocol, interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func setLanguages(_ languages: SelectedLanguages) {
        view?.setLanguages(languages)
    }
    
    func enterButtonTapped(text: String?) {
        interactor.translate(text ?? "")
    }
    
    func didTranslate(text: String) {
        view?.showTranslation(text: text)
    }
    
    func switchTapped() {
        interactor.switchTapped()
    }
    
    func sourceLanguageSelected() {
        interactor.sourceLanguageSelected()
    }
    
    func targetLanguageSelected() {
        interactor.targetLanguageSelected()
    }
    
    func presentLanguagesController(_ languages: SelectedLanguages, destination: DestinationLanguage, languagesSelected: @escaping (SelectedLanguages) -> Void) {
        router.presentLanguagesController(languages, destination: destination, languagesSelected: languagesSelected)
    }
}
