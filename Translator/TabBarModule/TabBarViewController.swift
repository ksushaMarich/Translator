//
//  ContainerViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 25.02.2025.
//

import UIKit

protocol TabBarViewControllerProtocol: AnyObject {}

class TabBarViewController: UITabBarController {

    var presenter: TabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuView()
    }
    
    private func setuView() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .black
    }
}

extension TabBarViewController: TabBarViewControllerProtocol {
    
}
