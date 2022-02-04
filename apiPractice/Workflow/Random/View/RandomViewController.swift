//
//  RandomViewController.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

protocol IRandomView: AnyObject {
    var presenter: IRandomPresenter? { get set }
}

protocol RandomDelegate: AnyObject {
    func updateUI(authorName: String,
                  description: String,
                  id: String,
                  likes: String,
                  representedIdentifier: String,
                  loadingImage: UIImage)
}

class RandomViewController: UIViewController {
    //MARK: - Constants and Variables
    var presenter: IRandomPresenter?
    private var posts: [Post] = []
    let networker = NetworkManager.shared
    weak var delegate: RandomDelegate?
    
    //MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = true
        collection.dataSource = self
        collection.delegate = self
        collection.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        
        return collection
    }()
    
    //MARK: - Life cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Random"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        
        setupNetwork()
    }
    
    private func setupNetwork() {
        networker.posts(query: "explore") { [weak self] posts, error in
            if let error = error {
                print("Error: ", error)
                return
            }
            self?.posts = posts!
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UI Modifications
extension RandomViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Protocol Inheritance
extension RandomViewController: IRandomView {
  
    
}

//MARK: - UICollectionView Delegate
extension RandomViewController: UICollectionViewDelegate {
}

//MARK: - UICollectionView DataSource
extension RandomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath) as! RandomCollectionViewCell
        
        cell.loadingImage.applyLoadingStryle(true)

        let post = posts[indexPath.item]

        let representedIdentifier = post.id
        cell.representedIdentifier = representedIdentifier

        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "picture")
        }

        networker.image(post: post) { data, error in
            let image = image(data: data)
            DispatchQueue.main.async {
                print(representedIdentifier, cell.representedIdentifier, representedIdentifier == cell.representedIdentifier)
                if cell.representedIdentifier == representedIdentifier {
                    cell.loadingImage.configure(image: image)
                    cell.loadingImage.applyLoadingStryle(false)
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        

        
        
        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "picture")
        }
        
        let post = posts[indexPath.item]
        
        

        let vc = DetailsViewController()
        vc.authorNameLabel.text =  "Author name: \(post.user.name ?? "-")"
        vc.descriptionLabel.text = "Description: \(post.description ?? "-")"
        vc.idLabel.text = "Picture id: \(post.id)"
        vc.likesLabel.text = "Total likes: \(post.likes)"
        vc.representedIdentifier = post.id
        
        vc.loadingImage.applyLoadingStryle(true)

        networker.image(post: post) { data, error in
            let image = image(data: data)
            DispatchQueue.main.async {
                vc.loadingImage.configure(image: image)
                vc.loadingImage.applyLoadingStryle(false)
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
