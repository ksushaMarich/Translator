//
//  SettingsInteractor.swift
//  Translator
//
//  Created by Ксюша on 22.03.2025.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {}

class SettingsInteractor {
    weak var presenter: SettingsPresenterProtocol?
}

extension SettingsInteractor: SettingsInteractorProtocol {}
