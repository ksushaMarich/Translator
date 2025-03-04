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
        #warning("переименовала метод интерактора")
        interactor.viewWillAppear()
    }
    
    func search(with text: String) {
        interactor.search(with: text)
    }
    
    func deleteButtonTapped() {
        interactor.deleteDictionary()
    }
    
    func setupDictionary(with queryTranslations: [QueryTranslation]) {
        view?.setupDictionary(with: queryTranslations)
    }
}
