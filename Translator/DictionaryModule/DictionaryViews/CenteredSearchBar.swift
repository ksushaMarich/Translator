//
//  CenteredSearchBar.swift
//  Translator
//
//  Created by Ксения Маричева on 28.02.2025.
//
import UIKit

protocol CenteredSearchBarProtocol: AnyObject {
    func textEntered(_ text: String)
}

class CenteredSearchBar: UIControl {
    
    // MARK: - Properties
    
    weak var delegate: CenteredSearchBarProtocol?
    
//    private lazy var viewWidthBaseConstraint = view.centerXAnchor.constraint(equalTo: centerXAnchor)
    private lazy var viewWidthBaseConstraint = view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.275)
    
    private lazy var viewWidthConstraint = viewWidthBaseConstraint
    
    private lazy var view: UIView = {
        let view = UIView()
//        view.axis = .horizontal
//        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconView: UIImageView = {
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
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.attributedPlaceholder = NSAttributedString(
                string: "Search Field",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
            )
        searchBar.font = UIFont.systemFont(ofSize: 17)
        return searchBar
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    
    private func setupControl() {
        let iconSide: CGFloat = 17
        let indent: CGFloat = 8

        addSubview(view)
        view.addSubview(iconView)
        view.addSubview(searchTextField)
        
//        view.addArrangedSubview(iconView)
//        view.addArrangedSubview(searchTextField)

        NSLayoutConstraint.activate([
            
            viewWidthConstraint,
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: indent),
            iconView.widthAnchor.constraint(equalToConstant: iconSide),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: iconSide),
            
            searchTextField.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 2 * indent),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -indent),
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func switchViewWidth(isExpanded: Bool) {
        
        viewWidthConstraint.isActive = false
//        viewWidthConstraint = isExpanded ? view.leadingAnchor.constraint(equalTo: leadingAnchor) : viewWidthBaseConstraint
        viewWidthConstraint = isExpanded ? view.widthAnchor.constraint(equalTo: widthAnchor) : viewWidthBaseConstraint
        viewWidthConstraint.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension CenteredSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switchViewWidth(isExpanded: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard searchTextField.text == "" else { return }
        switchViewWidth(isExpanded: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            delegate?.textEntered(text.replacingCharacters(in: textRange, with: string))
        }
        return true
    }
}
