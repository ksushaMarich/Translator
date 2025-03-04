//
//  LanguagesModuleBuilder.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import Foundation

class LanguagesModuleBuilder {
    static func build(selectedLanguages: SelectedLanguages, destination: DestinationLanguage, languagesSelected: @escaping (SelectedLanguages) -> Void) -> LanguagesViewController {
        let router = LanguagesRouter(languagesSelected: languagesSelected)
        let interactor = LanguagesInteractor(selectedLanguages: selectedLanguages, destination: destination)
        let presenter = LanguagesPresenter(router: router, interactor: interactor)
        let viewController = LanguagesViewController(presenter: presenter)
        //router.delegate = delegate
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
