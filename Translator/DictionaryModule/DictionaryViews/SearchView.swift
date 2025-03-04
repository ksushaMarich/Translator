//
//  SearchView.swift
//  Translator
//
//  Created by Ксения Маричева on 28.02.2025.
//

import UIKit

class SearchView: UIView {

    // MARK: - naming
    private lazy var searchIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .red
        textField.placeholder = "Поиск..."
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        textField.leftView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return textField
    }()
    
    // MARK: - init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    func setupView() {
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
