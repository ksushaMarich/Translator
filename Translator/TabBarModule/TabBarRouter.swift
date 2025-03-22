//
//  TabBarRouter.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol TabBarRouterProtocol: AnyObject {}

class TabBarRouter: TabBarRouterProtocol {
    
    weak var view: TabBarViewControllerProtocol?
    
    static func build() -> TabBarViewController {
        let router = TabBarRouter()
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter(router: router, interactor: interactor)
        let viewController = TabBarViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension SettingsRouter: TabBarRouterProtocol {}
