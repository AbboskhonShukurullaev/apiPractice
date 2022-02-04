//
//  RandomModule.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

class RandomModule {
    func buildModule() -> UIViewController {
        let view = RandomViewController()
        let presenter = RandomPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
