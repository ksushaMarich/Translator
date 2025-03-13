//
//  MainRouter.swift
//  Translator
//
//  Created by Ксения Маричева on 28.01.2025.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func presentLanguagesController(_ languages: SelectedLanguages, destination: DestinationLanguage, languagesSelected: @escaping (SelectedLanguages) -> Void)
}

class MainRouter {
    weak var view: MainViewControllerProtocol?

    private var presentationView: UIViewController? {
        view as? UIViewController
    }
}

extension MainRouter: MainRouterProtocol {
    
    static func build() -> MainViewController {
        let router = MainRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(router: router, interactor: interactor)
        let viewController = MainViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
    
    func presentLanguagesController(_ languages: SelectedLanguages, destination: DestinationLanguage, languagesSelected: @escaping (SelectedLanguages) -> Void) {
        
        presentationView?.navigationController?.pushViewController(LanguagesModuleBuilder.build(selectedLanguages: languages, destination: destination, languagesSelected: languagesSelected), animated: true)
    }
}
