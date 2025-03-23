//
//  TabBarRouter.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import UIKit

protocol TabBarRouterProtocol: AnyObject {
    func navigateToMain(with card: QueryTranslation)
}

class TabBarRouter {
    
    weak var view: TabBarViewControllerProtocol?
    
    static func build() -> TabBarViewController {
        let router = TabBarRouter()
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter(router: router, interactor: interactor)
        let viewController = TabBarViewController()
        
        let mainModule = MainRouter.build(with: router)
        let dictionaryModule = DictionaryRouter.build(with: router)
        let settingsModule = SettingsRouter.build(with: router)
        
        viewController.viewControllers = [mainModule, dictionaryModule, settingsModule]
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension TabBarRouter: TabBarRouterProtocol {
    func navigateToMain(with card: QueryTranslation) {
        guard let tabBarController = view as? UITabBarController,
              let mainModule = tabBarController.viewControllers?.first as? MainViewController else { return }
        
        mainModule.presenter?.setTranslationCard(card)
        tabBarController.selectedIndex = 0
    }
}
