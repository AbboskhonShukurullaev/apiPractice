//
//  RandomDetailsViewController.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    let networker = NetworkManager.shared
    private var post: Post?
    
    var representedIdentifier: String = ""
    var listOfIds: [String]? = []
    
    
    let defaults = UserDefaults.standard
    var savedArray = UserDefaults.standard.stringArray(forKey: "array")
    var isLiked: Bool = false

    
    lazy var loadingImage: LoadingImageView = {
        let loadingImage = LoadingImageView()
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        return loadingImage
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Like!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "More Details"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        

        print("View did load Represented identifier: \(representedIdentifier)")
//        listOfIds?.append(representedIdentifier)
        print("View did load List of ids: \(listOfIds)")
        
        setupUI()
        getButtonData()
    }
    
    @objc func likeButtonAction() {
       
        
        isLiked = !isLiked

        checkButton(state: isLiked)
        
    }
    
    func getButtonData() {
//        let retrieveData = defaults.object(forKey: "isLiked")
        let retrieveIdData = defaults.object(forKey: "array")
        
//        var like: Bool = true
//        if let bringData = retrieveData as? Bool,
           if let data = retrieveIdData as? [String] {
                
            for search in data {
                if search.contains(representedIdentifier) {
                    print("State is Liked")
                    print("IDs match: \(search) == \(representedIdentifier)")
                    isLiked = true
                    check(state: true)
                    break
                    
                } else {
                    print("State is not Liked")
                    print("IDs dont match: \(search) != \(representedIdentifier)")
                    check(state: false)
//                    isLiked = false
                }
            }
    
            } else {
                print("IDs DONT match")
            }
    }
    
//    func resetDefaults() {
//
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//    }
    
    func check(state: Bool) {
        if state == true {
            print("Liked!")

            print("Saved array: \(savedArray)")
            print("New List: \(listOfIds)")
            
            likeButton.backgroundColor = .systemBlue
            likeButton.setTitle("Unlike!", for: .normal)
            likeButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            print("Unliked!")
  
            print("Saved array: \(savedArray)")
            print("New List: \(listOfIds)")
            
            likeButton.backgroundColor = .systemRed
            likeButton.setTitle("Like!", for: .normal)
            likeButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func checkButton(state: Bool) {
        
        if state == true {
            print("Liked!")

            listOfIds?.append(representedIdentifier)
            
            
            if savedArray == nil {
                savedArray = listOfIds
            } else {
                savedArray! += listOfIds!
            }
            
            
            defaults.set(savedArray, forKey: "array")
            print("Saved array: \(savedArray)")
            print("New List: \(listOfIds)")
            
            likeButton.backgroundColor = .systemBlue
            likeButton.setTitle("Unlike!", for: .normal)
            likeButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            print("Unliked!")
   
            if listOfIds?.isEmpty == false {
                listOfIds?.removeFirst()
            }
            
            if savedArray?.contains(representedIdentifier) == true {
                savedArray = savedArray?.filter { $0 != representedIdentifier }
            }
            
            defaults.set(savedArray, forKey: "array")
            
            print("Saved array: \(savedArray)")
            print("New List: \(listOfIds)")
            
            likeButton.backgroundColor = .systemRed
            likeButton.setTitle("Like!", for: .normal)
            likeButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}

//MARK: - UI Modifications
extension DetailsViewController {
    private func setupUI() {
        [loadingImage,
         authorNameLabel,
         descriptionLabel,
         idLabel,
         likesLabel,
         likeButton].forEach { view.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loadingImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            loadingImage.heightAnchor.constraint(equalToConstant: 300),
            
            idLabel.topAnchor.constraint(equalTo: loadingImage.bottomAnchor, constant: 30),
            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            idLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            authorNameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 15),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            authorNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            likesLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 15),
            likesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            likesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            descriptionLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            likeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            likeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
