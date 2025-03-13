//
//  ContainerViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 25.02.2025.
//

import UIKit

class ContainerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .black
        
        let dictionaryModule = DictionaryRouter.build()
        let mainModule = MainRouter.build()
        let settingsModule = SettingsViewController()
        
        mainModule.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "translate"), tag: 0)
        dictionaryModule.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book.pages"), tag: 1)
        settingsModule.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape.fill"), tag: 2)
        
        viewControllers = [mainModule, dictionaryModule, settingsModule]
    }
}
