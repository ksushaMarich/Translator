//
//  SearchHeaderView.swift
//  Translator
//
//  Created by Ксюша on 30.03.2025.
//

import UIKit

class SearchHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "SearchHeaderView"
    
    weak var delegate: CenteredSearchBarProtocol? {
        didSet {
            searchBar.delegate = delegate
        }
    }
    
    private lazy var searchBar: CenteredSearchBar = {
        let searchBar = CenteredSearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    init() {
        super.init(reuseIdentifier: SearchHeaderView.identifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(searchBar)
        addSubview(separatorView)

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
