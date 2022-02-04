//
//  MainPresenter.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

protocol IMainPresenter: AnyObject {
    var view: IMainView? { get set }
    
    func viewDidAppear()
}

class MainPresenter {
    weak var view: IMainView?
    weak var viewController: UIViewController?
}

extension MainPresenter: IMainPresenter {
    func viewDidAppear() {
        view?.showHome()
    }
}
