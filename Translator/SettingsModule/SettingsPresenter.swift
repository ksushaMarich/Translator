//
//  SettingsPresenter.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {}

class SettingsPresenter {
    weak var view: SettingsViewControllerProtocol?
    var router: SettingsRouterProtocol
    var interactor: SettingsInteractorProtocol
    
    init(router: SettingsRouterProtocol, interactor: SettingsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {}
