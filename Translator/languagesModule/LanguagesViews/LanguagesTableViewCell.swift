//
//  LanguagesTableViewCell.swift
//  Translator
//
//  Created by Ксения Маричева on 03.02.2025.
//

import UIKit

class LanguageCell: UITableViewCell {

    // MARK: - naming
    static var identifier = "LanguagesTableViewCell"
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    private func setupCell() {
        contentView.addSubview(languageLabel)
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            languageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            languageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with language: Language) {
        languageLabel.text = language.description()
    }
    
    func setLanguageSelected() {
        languageLabel.font = .boldSystemFont(ofSize: 24)
    }
}
