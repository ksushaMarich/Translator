//
//  LanguagesRouter.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import UIKit

protocol LanguagesRouterProtocol: AnyObject {
    func closeController(with languages: SelectedLanguages?)
}

class LanguagesRouter {
    weak var view: LanguagesViewControllerProtocol?
    
    var languagesSelected: (SelectedLanguages) -> Void
    
    init(languagesSelected: @escaping (SelectedLanguages) -> Void) {
        self.languagesSelected = languagesSelected
    }
}

extension LanguagesRouter: LanguagesRouterProtocol {
    
    func closeController(with languages: SelectedLanguages? = nil) {
        (view as? UIViewController)?.navigationController?.popViewController(animated: true)
        guard let languages else { return }
        languagesSelected(languages)
    }
}
