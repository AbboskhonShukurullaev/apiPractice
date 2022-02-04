//
//  FavouritesPresenter.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation

protocol IFavouritesPresenter: AnyObject {
    var view: IFavouritesView? { get set }
}

class FavouritesPresenter {
    weak var view: IFavouritesView?
}

extension FavouritesPresenter: IFavouritesPresenter {
    
}
