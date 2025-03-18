//
//  DictionaryRouter.swift
//  Translator
//
//  Created by Ксения Маричева on 18.02.2025.
//

import Foundation

protocol DictionaryRouterProtocol {
    
}

class DictionaryRouter {
    #warning("перенесла функцию сюда что бы роутер отвечал за создание модуля")
    weak var view: DictionaryViewControllerProtocol?
    static func build() -> DictionaryViewController {
        let router = DictionaryRouter()
        let interactor = DictionaryInteractor()
        let presenter = DictionaryPresenter(router: router, interactor: interactor)
        let viewController = DictionaryViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension DictionaryRouter: DictionaryRouterProtocol {
    
}
