//
//  HomePresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol{
    var view: HomeViewProtocol?
    
    static func createHomeModule()->UIViewController{
        let view = HomeScreenVC()
        var presenter: HomePresenterProtocol = HomePresenter()
        presenter.view = view
        view.presenter = presenter
        return view
    }
}
