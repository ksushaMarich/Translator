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
    private lazy var viewWidthConstraint = view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.275)
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var searchView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "magnifyingglass")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.tintColor = .systemGray
        return view
    }()

    private lazy var searchTextField: UITextField = {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
            )
        searchBar.font = UIFont.systemFont(ofSize: 17)
        return searchBar
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
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
        addSubview(separatorView)

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
            searchView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: 2 * indent),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -indent),
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
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
        viewWidthConstraint = view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.275)
        viewWidthConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
