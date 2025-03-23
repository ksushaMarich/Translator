//
//  DictionaryInteractor.swift
//  Translator
//
//  Created by Ксения Маричева on 18.02.2025.
//

import Foundation

protocol DictionaryInteractorProtocol: AnyObject {
    func viewWillAppear()
    func search(with text: String)
    func deleteDictionary()
    func translationCardSelected(with index: Int)
}

class DictionaryInteractor {
    weak var presenter: DictionaryPresenterProtocol?
    private let coreDataManager = CoreDataManager.shared
    
    private var translationCards: [QueryTranslation] {
        coreDataManager.fetchTranslations()
    }
    
    private func filterTranslations(with text: String ) -> [QueryTranslation] {
        translationCards.filter {
            $0.original.lowercased().contains(text.lowercased()) ||
            $0.translation.lowercased().contains(text.lowercased())
        }
    }
}

extension DictionaryInteractor: DictionaryInteractorProtocol {

    func viewWillAppear() {
        presenter?.setupDictionary(with: translationCards)
    }
    
    func search(with text: String) {
        presenter?.setupDictionary(with: text.isEmpty ? translationCards : filterTranslations(with: text))
    }
    
    func deleteDictionary() {
        coreDataManager.deleteTranslations()
        presenter?.setupDictionary(with: translationCards)
    }
    
    func translationCardSelected(with index: Int) {
        presenter?.showTranslationCard(translationCards[index])
    }
}
