//
//  FavouritesViewController.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

protocol IFavouritesView: AnyObject {
    var presenter: IFavouritesPresenter? { get set }
}

class FavouritesViewController: UIViewController {
    //MARK: - Constants and Properties
    var presenter: IFavouritesPresenter?
    private var posts: [Post] = []
    //    var post: Post?
    let networker = NetworkManager.shared
    let defaults = UserDefaults.standard
    var savedArray = UserDefaults.standard.stringArray(forKey: "array")
    
    //MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Life cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Favourites"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        setupNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        defaults.set(savedArray, forKey: "array")
//                self.tableView.reloadData()
//        UserDefaults.resetStandardUserDefaults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupNetwork() {
        networker.posts(query: "explore") { [weak self] posts, error in
            if let error = error {
                print("Error: ", error)
                return
            }
            self?.posts = posts!
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


//MARK: - UI Modifications
extension FavouritesViewController {
    private func setupUI() {
        view.addSubview(tableView)
    }
}
//MARK: - Protocol Inheritance
extension FavouritesViewController: IFavouritesView {
}

//MARK: - TableView Delegate & DataSource
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as! FavouritesTableViewCell
        
        print(posts.count)
        
        
        if posts.count > 0  {
            
            let post = posts[indexPath.item]
            
            let representedIdentifier = post.id
            cell.representedIdentifier = representedIdentifier
            
            
//            if ((savedArray?.contains(representedIdentifier)) == true) {
//                print("SAVED ARRAY: ", representedIdentifier)
                
                cell.titleLabel.text = post.user.name
                
                func image(data: Data?) -> UIImage? {
                    if let data = data {
                        return UIImage(data: data)
                    }
                    return UIImage(systemName: "picture")
                }
                
                cell.loadingImage.applyLoadingStryle(true)
                
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
//            } else {
//
//            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
