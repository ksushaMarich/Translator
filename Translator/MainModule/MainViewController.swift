//
//  ViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 28.01.2025.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func showTranslation(text: String)
    func setLanguages(_ languages: SelectedLanguages)
    func textDidChange()
    #warning("Новое")
    func deleteTranslation()
    func setTranslation(_ translation: )
}

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol?
    
    // MARK: - language stackView
    private lazy var languageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var turnOverView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrow.left.and.right")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchTapped)))
        return view
    }()
    
    private lazy var sourceLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = Style.languageFont
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sourceLanguageSelected)))
        return label
    }()
    
    private lazy var targetLanguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = Style.languageFont
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(targetLanguageSelected)))
        return label
    }()
    // MARK: - translateStackView
    private lazy var translateStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.axis = .vertical
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 1
        return view
    }()
    
    private lazy var translationTextView: PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.listener = self
        textView.font = Style.titleFont
        textView.placeholder = "Text or website address"
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = Style.textContainerInset
        return textView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var translationLabel: TranslationLabel = {
        let label = TranslationLabel(textInsets: Style.textContainerInset)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        label.font = Style.titleFont
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        view.backgroundColor = Style.themeColor
        
        view.addSubview(languageStackView)
        view.addSubview(translateStackView)
        languageStackView.addArrangedSubview(sourceLanguageLabel)
        languageStackView.addArrangedSubview(turnOverView)
        languageStackView.addArrangedSubview(targetLanguageLabel)
        
        translateStackView.addArrangedSubview(translationTextView)
        translateStackView.addSubview(separatorView)
        translateStackView.addArrangedSubview(translationLabel)
        
        NSLayoutConstraint.activate([
            languageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            languageStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            languageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            languageStackView.heightAnchor.constraint(equalToConstant: 50),
            
            sourceLanguageLabel.widthAnchor.constraint(equalTo: turnOverView.widthAnchor, multiplier: 5.5),
            targetLanguageLabel.widthAnchor.constraint(equalTo: sourceLanguageLabel.widthAnchor),
            
            translateStackView.topAnchor.constraint(equalTo: languageStackView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            translateStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            translateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            translateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            translationLabel.heightAnchor.constraint(equalTo: translationTextView.heightAnchor, multiplier: 3.5),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.centerXAnchor.constraint(equalTo: translateStackView.centerXAnchor),
            separatorView.widthAnchor.constraint(equalTo: translateStackView.widthAnchor, multiplier: 0.9),
            separatorView.topAnchor.constraint(equalTo: translationTextView.bottomAnchor)
        ])
    }
    
    private func clear() {
        translationTextView.text = ""
        translationLabel.text = ""
    }
    
    @objc private func switchTapped() {
        presenter?.switchTapped()
    }
    
    @objc private func sourceLanguageSelected() {
        presenter?.sourceLanguageSelected()
    }
    
    @objc private func targetLanguageSelected() {
        presenter?.targetLanguageSelected()
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func setLanguages(_ languages: SelectedLanguages) {
        sourceLanguageLabel.text = languages.source.description()
        targetLanguageLabel.text = languages.target.description()
    }
    
    func showTranslation(text: String) {
        translationLabel.text = text
    }
    
    #warning("Новое")
    func deleteTranslation() {
        translationLabel.text = ""
    }
}

extension MainViewController: PlaceholderTextViewDelegate {
    
    func didEnter(text: String) {
        presenter?.enterButtonTapped(text: text)
    }
    
    #warning("Новое")
    func textDidChange() {
        presenter?.textDidChange()
    }
}
