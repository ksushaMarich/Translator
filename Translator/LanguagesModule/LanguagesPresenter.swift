//
//  LanguagesPresenter.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import Foundation

protocol LanguagesPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func setLanguages(_ languages: [Language], header: String, highlightedRowIndex: Int)
    func didSelectRowAt(_ index: Int)
    func changeSelectedLanguages(_ languages: SelectedLanguages)
    func crossTapped()
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
    
    func setLanguages(_ languages: [Language], header: String, highlightedRowIndex: Int) {
        view?.setLanguages(languages, header: header, highlightedRowIndex: highlightedRowIndex)
    }
    
    func didSelectRowAt(_ index: Int) {
        interactor.didSelectRowAt(index)
    }
    
    func changeSelectedLanguages(_ languages: SelectedLanguages) {
        router.closeController(with: languages)
    }
    
    func crossTapped() {
        router.closeController(with: nil)
    }
}
