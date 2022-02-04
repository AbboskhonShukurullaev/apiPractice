//
//  ViewController.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

protocol IMainView: AnyObject {
    var presenter: IMainPresenter? { get set }
    
    func showHome()
}

class MainViewController: UIViewController {
    var presenter: IMainPresenter?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter?.viewDidAppear()
    }
}

extension MainViewController: IMainView {
    func showHome() {
        let viewController = HomeModule().buildModule()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
