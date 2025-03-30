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
    
    private func switchLanguages() {
        selectedLanguages = (selectedLanguages.target, selectedLanguages.source)
    }
}

extension LanguagesInteractor: LanguagesInteractorProtocol {
    
    func viewDidLoaded() {
        
        let selectedLanguage: Language
        
        switch destination {
        case.source:  selectedLanguage = selectedLanguages.source
        case .target: selectedLanguage = selectedLanguages.target
        }
        
        let highlightedRowIndex = languages.firstIndex(of: selectedLanguage) ?? 0
        presenter?.setLanguages(languages, header: destination.header, highlightedRowIndex: highlightedRowIndex)
    }
    
    func didSelectRowAt(_ index: Int) {
        
        let selectedLanguage = languages[index]
        
        switch destination {
        case .source:
            if selectedLanguages.target == selectedLanguage {
                switchLanguages()
            } else {
                selectedLanguages.source = selectedLanguage
            }
        case .target:
            if selectedLanguages.source == selectedLanguage {
                switchLanguages()
            } else {
                selectedLanguages.target = selectedLanguage
            }
        }
        
        presenter?.changeSelectedLanguages(selectedLanguages)
    }
}
