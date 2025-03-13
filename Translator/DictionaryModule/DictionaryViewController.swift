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
    
    #warning("Новый лейбел")
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "History"
        label.font = UIFont.systemFont(ofSize: 23)
        label.textAlignment = .center
        return label
    }()
    
    #warning("Новое вью с табжестеррекогнайзером")
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.barTintColor = .white
        searchBar.searchTextField.backgroundColor = .white
        return searchBar
    }()
    
    private lazy var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DictionaryCell.self, forCellReuseIdentifier: DictionaryCell.identifier)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = searchBar
        view.separatorInset.right = CGFloat(20)
        view.separatorInset.left = view.separatorInset.right
        return view
    }()

    //MARK: - life cycle
    
    #warning("Перенесла все в viewWillAppear что бы при нажатии на тачбар отображались новые результаты")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        #warning("переименовала метод презентора")
        view.backgroundColor = Style.themeColor
        presenter?.viewWillAppear()
    }
    
    //MARK: - methods
#warning("удалила функцию отвечающию за внешний вид navigationController")
    private func setupView() {
        view.addSubview(historyLabel)
        view.addSubview(trashView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            historyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyLabel.heightAnchor.constraint(equalToConstant: 50),
            historyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            
            trashView.centerYAnchor.constraint(equalTo: historyLabel.centerYAnchor),
            trashView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trashView.heightAnchor.constraint(equalTo: historyLabel.heightAnchor),
            trashView.widthAnchor.constraint(equalTo: trashView.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: historyLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func deleteAll() {
        presenter?.deleteButtonTapped()
    }
}

extension DictionaryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(with: searchText)
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
}

extension DictionaryViewController: DictionaryViewControllerProtocol {
    func setupDictionary(with queryTranslations: [QueryTranslation]) {
        translations = queryTranslations
        tableView.reloadData()
    }
}
