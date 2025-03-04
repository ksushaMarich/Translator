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
    //weak var delegate: MainPresenterDelegate?
    var languagesSelected: (SelectedLanguages) -> Void
    
    init(languagesSelected: @escaping (SelectedLanguages) -> Void) {
        self.languagesSelected = languagesSelected
    }
}

extension LanguagesRouter: LanguagesRouterProtocol {
#warning("изменила функцию что бы она работала и для крестика и при выборе языка")
    func closeController(with languages: SelectedLanguages? = nil) {
        //delegate?.didSelectLanguage(languages)
        if let languages {
            languagesSelected(languages)
        }
        (view as? UIViewController)?.navigationController?.popViewController(animated: true)
    }
}
