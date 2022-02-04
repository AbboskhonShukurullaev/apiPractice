//
//  LoadingImageView.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

class LoadingImageView: UIView {
    //MARK: - UI Elements
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.clipsToBounds = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = self.frame.height / 8
    }
    
    //MARK: - Methods
    public func configure(image: UIImage?) {
        imageView.image = image
    }
    
    func applyLoadingStryle(_ value: Bool) {
        
        if value {
            self.activityIndicator.startAnimating()
            self.imageView.isHidden = true
        } else {
            self.activityIndicator.stopAnimating()
            self.imageView.isHidden = false
        }
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        [activityIndicator,
         imageView].forEach { self.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
