//
//  DictionaryPresenter.swift
//  Translator
//
//  Created by Ксения Маричева on 18.02.2025.
//

import Foundation

protocol DictionaryPresenterProtocol: AnyObject {
    func viewWillAppear()
    func search(with text: String)
    func setupDictionary(with queryTranslations: [QueryTranslation])
    func deleteButtonTapped()
    func cellSelected(for index: Int)
    func showTranslationCard(_ card: QueryTranslation)
}

class DictionaryPresenter {
    weak var view: DictionaryViewControllerProtocol?
    
    var router: DictionaryRouterProtocol
    var interactor: DictionaryInteractorProtocol
    
    init(router: DictionaryRouterProtocol, interactor: DictionaryInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension DictionaryPresenter: DictionaryPresenterProtocol {
    
    func viewWillAppear() {
        interactor.viewWillAppear()
    }
    
    func search(with text: String) {
        interactor.search(with: text)
    }
    
    func deleteButtonTapped() {
        interactor.deleteDictionary()
    }
    
    func setupDictionary(with translationCards: [QueryTranslation]) {
        view?.setupDictionary(with: translationCards)
    }
    
    func cellSelected(for index: Int) {
        interactor.translationCardSelected(with: index)
    }
    
    func showTranslationCard(_ card: QueryTranslation) {
        router.navigateToMain(with: card)
    }
}
