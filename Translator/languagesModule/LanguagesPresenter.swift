//
//  LanguagesPresenter.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import Foundation

protocol LanguagesPresenterProtocol: AnyObject {
    func viewDidLoaded()
    #warning("Добавила выбраный язык")
    func setLanguages(_ languages: [Language], header: String, selecdedLanguage: Language)
    func didSelectRowAt(_ index: Int)
    func changeSelectedLanguages(_ languages: SelectedLanguages)
    func closeTapped()
}

class LanguagesPresenter {
    
    weak var view: LanguagesViewControllerProtocol?
    
    var router: LanguagesRouterProtocol
    var interactor: LanguagesInteractorProtocol
    
    init(router: LanguagesRouterProtocol, interactor: LanguagesInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension LanguagesPresenter: LanguagesPresenterProtocol {
    
    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    #warning("Немного изменила функцию")
    func setLanguages(_ languages: [Language], header: String, selecdedLanguage: Language) {
        view?.setLanguages(languages, selectedLanguage: selecdedLanguage, header: header)
    }
    
    func didSelectRowAt(_ index: Int) {
        interactor.didSelectRowAt(index)
    }
    
    func changeSelectedLanguages(_ languages: SelectedLanguages) {
        router.closeController(with: languages)
    }
    
    func closeTapped() {
        router.closeController(with: nil)
    }
}
