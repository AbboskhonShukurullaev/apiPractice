//
//  RandomPresenter.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

protocol IRandomPresenter: AnyObject {
    var view: IRandomView? { get set }

}

class RandomPresenter {
    //MARK: - Constants and Variables
    weak var view: IRandomView?
    weak var viewController: UIViewController?
    var posts: [Post] = []
    let networker = NetworkManager.shared
    
}

extension RandomPresenter: IRandomPresenter {

}
