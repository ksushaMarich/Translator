//
//  DictionaryViewController.swift
//  Translator
//
//  Created by Ксения Маричева on 18.02.2025.
//

import UIKit

protocol DictionaryViewControllerProtocol: AnyObject {
    func setupDictionary(with queryTranslations: [QueryTranslation])
}

class DictionaryViewController: UIViewController {
    
    //MARK: - naming
    var presenter: DictionaryPresenterProtocol?
    
    private var translations: [QueryTranslation] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "History"
        label.font = Style.titleFont
        label.textAlignment = .center
        return label
    }()
    
    private lazy var trashView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "trash.fill")
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteAll)))
        return view
    }()

    private lazy var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DictionaryCell.self, forCellReuseIdentifier: DictionaryCell.identifier)
        view.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchHeaderView.identifier)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.separatorInset.right = CGFloat(20)
        view.separatorInset.left = view.separatorInset.right
        view.sectionHeaderTopPadding = 0
        return view
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        view.backgroundColor = Style.themeColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Methods

    private func setupView() {
        
        viewAddGestureRecognizer()
        
        view.addSubview(titleLabel)
        view.addSubview(trashView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            
            trashView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            trashView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trashView.heightAnchor.constraint(equalToConstant: 27),
            trashView.widthAnchor.constraint(equalTo: trashView.heightAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func viewAddGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func deleteAll() {
        presenter?.deleteButtonTapped()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}



extension DictionaryViewController: CenteredSearchBarProtocol {
    func textEntered(_ text: String) {
        presenter?.search(with: text)
    }
}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DictionaryCell.identifier) as? DictionaryCell else {
            return UITableViewCell()
        } 
        cell.configure(with: translations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchHeaderView()
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.cellSelected(for: indexPath.row)
    }
}

extension DictionaryViewController: DictionaryViewControllerProtocol {
    func setupDictionary(with queryTranslations: [QueryTranslation]) {
        translations = queryTranslations
        tableView.reloadData()
    }
}
