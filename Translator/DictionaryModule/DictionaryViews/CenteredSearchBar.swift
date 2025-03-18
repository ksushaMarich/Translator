//
//  CenteredSearchBar.swift
//  Translator
//
//  Created by Ксения Маричева on 28.02.2025.
//
import UIKit

#warning("Перепесала класс")
class CenteredSearchBar: UIControl {
    
    // MARK: - Properties
    private lazy var viewWidthConstraint = view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    private lazy var searchView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "magnifyingglass")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private lazy var searchTextField: UITextField = {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .red
        searchBar.placeholder = "Попа"
        return searchBar
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupControl() {
        let iconSize: CGFloat = 17
        let indent: CGFloat = 8

        addSubview(view)
        view.addSubview(searchView)
        view.addSubview(searchTextField)

        NSLayoutConstraint.activate([
            
            viewWidthConstraint,
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor),
            
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent),
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.heightAnchor.constraint(equalToConstant: iconSize),
            searchView.widthAnchor.constraint(equalToConstant: iconSize),
            searchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: indent),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -indent),
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])

        // Добавляем слушатели фокуса текстового поля
        searchTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }

    // MARK: - Animations
    @objc private func textFieldDidBeginEditing() {
        viewWidthConstraint.isActive = false

        // Создаём новый констрейнт, занимающий всю ширину
        viewWidthConstraint = view.widthAnchor.constraint(equalTo: widthAnchor)
        viewWidthConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    @objc private func textFieldDidEndEditing() {
        
        guard searchTextField.text == "" else { return }
        viewWidthConstraint.isActive = false

        // Создаём новый констрейнт, занимающий всю ширину
        viewWidthConstraint = view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        viewWidthConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
