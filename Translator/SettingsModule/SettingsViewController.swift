//
//  SettingsViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 25.02.2025.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {}

class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Style.themeColor
    }
}

extension SettingsViewController: SettingsViewControllerProtocol {}
