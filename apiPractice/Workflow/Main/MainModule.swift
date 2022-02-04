//
//  MainModule.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation
import UIKit

class MainModule {
    func buildModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
