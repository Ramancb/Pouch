//
//  HomeProtocols.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation
///  Home module view protocol
protocol HomeViewProtocol{
    var presenter:HomePresenterProtocol? {get set}
    func updateCategoryCollection(categories:[CategoryData]?)
    func updateCardsCollection(data:[CardsData]?)
    func configureUserName()
}

/// Home Module Presenter protocol
protocol HomePresenterProtocol{
    var view:HomeViewProtocol? {get set}
    func getCardsCategories()
    func apiCallTOGetCardsData()
    func getTemplates()
    func getUserProfile()
}
