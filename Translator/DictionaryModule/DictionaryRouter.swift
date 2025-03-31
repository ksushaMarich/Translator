//
//  DictionaryRouter.swift
//  Translator
//
//  Created by Ксения Маричева on 18.02.2025.
//

import UIKit

protocol DictionaryRouterProtocol {
    func navigateToMain(with card: QueryTranslation)
}

class DictionaryRouter {
    
    weak var tabBarRouter: TabBarRouterProtocol?
    
    weak var view: DictionaryViewControllerProtocol?
    
    static func build(with tabBarRouter: TabBarRouterProtocol) -> DictionaryViewController {
        let router = DictionaryRouter()
        router.tabBarRouter = tabBarRouter
        let interactor = DictionaryInteractor()
        let presenter = DictionaryPresenter(router: router, interactor: interactor)
        let viewController = DictionaryViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book.pages"), tag: 1)
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension DictionaryRouter: DictionaryRouterProtocol {
    
    func navigateToMain(with card: QueryTranslation) {
        tabBarRouter?.navigateToMain(with: card)
    }
}
