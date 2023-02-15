//
//  InformationPresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 15/02/23.
//

import UIKit

class InformationPresenter: InformationPresenterProtocol{
    var view: InformationViewProtocol?
    
    static func createInformationModule() -> UIViewController{
         let vc = InformationPopUpController()
            var presenter: InformationPresenterProtocol = InformationPresenter()
            presenter.view = vc
            vc.presenter = presenter
            return vc
    }
    
}
