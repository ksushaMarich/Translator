//
//  SettingsRouter.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol SettingsRouterProtocol: AnyObject {}

class SettingsRouter {
    
    weak var view: SettingsViewControllerProtocol?
    
    static func build() -> SettingsViewController {
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        let viewController = SettingsViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}

extension SettingsRouter: SettingsRouterProtocol {}
