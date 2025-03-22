//
//  TabBarPresenter.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject {}

class TabBarPresenter {
    weak var view: TabBarViewControllerProtocol?
    var router: TabBarRouterProtocol
    var interactor: TabBarInteractorProtocol
    
    init(router: TabBarRouterProtocol, interactor: TabBarInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: TabBarPresenterProtocol {}
