//
//  FavouritesTableViewCell.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    //MARK: - Constants & Properties
    static let identifier = "FavouritesTableViewCell"
    var representedIdentifier: String = ""
    
    //MARK: - UI Elements
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5.0
        [loadingImage,
         titleLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    lazy var loadingImage: LoadingImageView = {
        let loadingImage = LoadingImageView()
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        return loadingImage
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Abboskhon Shukurullaev"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingImage.imageView.image = nil
    }
}

//MARK: - UI Modifications
extension FavouritesTableViewCell {
    //MARK: - Private Methods
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.addSubview(horizontalStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),

            loadingImage.heightAnchor.constraint(equalToConstant: 140),
            loadingImage.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
}
