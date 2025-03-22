//
//  TabBarInteractor.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol TabBarInteractorProtocol: AnyObject {}

class TabBarInteractor {
    weak var presenter: TabBarPresenterProtocol?
}

extension SettingsInteractor: TabBarInteractorProtocol {}
