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
    
    private let indent: CGFloat = 8
    
    weak var delegate: CenteredSearchBarProtocol?
    
    private lazy var viewXConstraint = viewBaseXConstraint
    private lazy var viewBaseXConstraint = view.centerXAnchor.constraint(equalTo: centerXAnchor)
    
    private lazy var view: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
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
                string: "Search",
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

        addSubview(view)
        view.addSubview(iconView)
        view.addSubview(searchTextField)
        
        view.addArrangedSubview(iconView)
        view.addArrangedSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewXConstraint,
            
            iconView.widthAnchor.constraint(equalToConstant: iconSide)
        ])
    }
    
    private func switchViewWidth(isExpanded: Bool) {
        
        viewXConstraint.isActive = false
        viewXConstraint = isExpanded ? view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: indent) : viewBaseXConstraint
        viewXConstraint.isActive = true
        
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
