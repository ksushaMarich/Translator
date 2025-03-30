//
//  LanguagesViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import UIKit

protocol LanguagesViewControllerProtocol: AnyObject {
    func setLanguages(_ languages: [Language], header: String, highlightedRowIndex: Int)
}

class LanguagesViewController: UIViewController {

    // MARK: - naming
    var presenter: LanguagesPresenterProtocol
    
    private var languages: [Language] = []
    private var header: String = ""
    private var highlightedRowIndex: Int = 0
    
    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Style.titleFont
        label.text = header
        return label
    }()
    
    private lazy var crossView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "xmark")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(crossTapped)))
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.contentInsetAdjustmentBehavior = .never
        view.sectionHeaderTopPadding = 0
        view.backgroundColor = .systemBackground
        view.separatorInset = .zero
        view.separatorStyle = .none
        return view
    }()
    
    init(presenter: LanguagesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoaded()
        setupView()
    }
    
    // MARK: - methods
    
    private func setupView() {
        view.backgroundColor = Style.themeColor
        
        view.addSubview(destinationLabel)
        view.addSubview(crossView)
        view.addSubview(separatorView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            destinationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            destinationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            destinationLabel.heightAnchor.constraint(equalToConstant: 50),
            destinationLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            
            crossView.centerYAnchor.constraint(equalTo: destinationLabel.centerYAnchor),
            crossView.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor, multiplier: 0.55),
            crossView.widthAnchor.constraint(equalTo: crossView.heightAnchor),
            crossView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            separatorView.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func crossTapped() {
        presenter.crossTapped()
    }
}

extension LanguagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier) as? LanguageCell else {
            return UITableViewCell()
        }
        
        if highlightedRowIndex == indexPath.row {
            cell.setHighlighted()
        }
        
        cell.configure(with: languages[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath.row)
    }
}

extension LanguagesViewController: LanguagesViewControllerProtocol {
    
    func setLanguages(_ languages: [Language], header: String, highlightedRowIndex: Int) {
        self.languages = languages
        self.header = header
        self.highlightedRowIndex = highlightedRowIndex
        tableView.reloadData()
    }
}
