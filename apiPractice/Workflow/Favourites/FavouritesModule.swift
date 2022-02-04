//
//  FavouritesModule.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import UIKit

class FavouritesModule {
    func buildModule() -> UIViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
