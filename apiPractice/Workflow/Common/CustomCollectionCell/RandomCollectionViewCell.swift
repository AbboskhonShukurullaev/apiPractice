//
//  CustomCollectionViewCell.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

class RandomCollectionViewCell: UICollectionViewCell {
    //MARK: - Constants & Properties
    static let identifier = "RandomCollectionViewCell"
    var representedIdentifier: String = ""
    
    //MARK: - UI Elements
    lazy var loadingImage: LoadingImageView = {
        let loadingImage = LoadingImageView()
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        return loadingImage
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
extension RandomCollectionViewCell {
    //MARK: - Private Methods
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.addSubview(loadingImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            loadingImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            loadingImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            loadingImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
