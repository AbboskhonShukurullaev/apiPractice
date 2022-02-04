//
//  HomePresenter.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

protocol IHomePresenter: AnyObject {
    var view: IHomeView? { get set }
    
    func setupViewControllers()
}

class HomePresenter {
    weak var view: IHomeView?
}

extension HomePresenter: IHomePresenter {
    func setupViewControllers() {
        guard let viewControllers = view?.getViewControllers() else {
            return
        }
        
        self.view?.display(viewControllers)
    }
}
