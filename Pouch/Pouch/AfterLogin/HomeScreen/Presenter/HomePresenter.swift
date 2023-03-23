//
//  HomePresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation
import UIKit
import CouchbaseLiteSwift
import ObjectMapper

class HomePresenter: HomePresenterProtocol{
    
    var view: HomeViewProtocol?
    
    /// Initialize view and presenter for home module
    static func createHomeModule()->UIViewController{
        let view = HomeScreenVC()
        var presenter: HomePresenterProtocol = HomePresenter()
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func apiCallTOGetCardsData(){
        
        if Singleton.alreadyLogin == true{
            DatabaseManager.shared.fetchOverAllData(dbName: DatabaseManager.kDBName) { json, error in
                if error == nil{
                    let cardsData = Mapper<CardsData>().mapArray(JSONArray: json ?? [[:]])
                    self.view?.updateCardsCollection(data: cardsData)
                }
            }
        }else {
            ApiHandler.call(apiName: API.Name.get_cards) { (data:UserCardsModel?, error) in
                guard let cardsData = data?.response else{return}
                let filterData = cardsData.filter({$0.type != CardType.boardingPass.rawValue})
                self.mergeTemplateData(cards: filterData)
            }
        }
    }
    
    func mergeTemplateData(cards:[CardsData]){
        
        for card in cards{
            DatabaseManager.shared.createOrUpdateDocumentForDb(_id: card.id ?? "", dbName: DatabaseManager.kDBName, json: card.toJSON())
            guard let template_name = card.templateName else{return}
            DatabaseManager.shared.isDbDocumentExist(dbName: DatabaseManager.kTemplateDBName, templateName: template_name) { template,error  in
                if error != nil{
                    self.getTemplateWithNameApiCall(card: card) { isComplete in
                        if isComplete == true{
                            self.view?.updateCardsCollection(data: cards)
                        }
                    }
                }
            }
        }
//        self.view?.updateCardsCollection(data: cards)
    }
    
    func getTemplateWithNameApiCall(card:CardsData,handler: @escaping(_ isComplete: Bool)-> Void){
        ApiHandler.call(apiName: API.Name.templates_name, id: card.templateName) { (data:TemplateByNameModel?, error) in
            guard let data = data?.response else {
                handler(false)
                return
            }
            DatabaseManager.shared.createOrUpdateDocumentForDb(_id: data.id ?? "", dbName: DatabaseManager.kTemplateDBName, json: data.toJSON())
            handler(true)

        }
    }

    
    /// Api call to get cards categories list
    func getCardsCategories() {
        ApiHandler.call(apiName: API.Name.cards_categories) { (data:CategoriesModel?, error) in
            if error != nil{
                Singleton.showMessage(message: error ?? "", isError: .error)
            } else{
                self.view?.updateCategoryCollection(categories: data?.response)
            }
        }
    }
    /// Api call to get overall card templates
    func getTemplates() {
        apiCallToGetTemplates()
        //        DatabaseManager.shared.fetchOverAllData(dbName: DatabaseManager.kTemplateDBName) { (data, error) in
        //            if error == nil{
        //                if let jsonData = data, jsonData.count > 0{
        //                    let templates = Mapper<TemplatesData>().mapArray(JSONArray: jsonData)
        //                    self.getCardsData(templates: templates)
        //                }else{
        //                    apiCallToGetTemplates()
        //                }
        //            }else{
        //                apiCallToGetTemplates()
        //            }
        //        }
    }
    
    func apiCallToGetTemplates(){
        ApiHandler.call(apiName: API.Name.cards_user_templates) { (data:TemplatesModel?, error) in
            guard let template_data = data?.response else{return}
            //            for template in template_data{
            //                DatabaseManager.shared.createOrUpdateDocumentForDb(_id: template.id ?? "", dbName: DatabaseManager.kTemplateDBName, json: template.toJSON())
            //            }
//            self.getCardsData(templates: data?.response)
        }
    }
    /// Api call to get user profile data.
    func getUserProfile() {
        DatabaseManager.shared.fetchOverAllData(dbName: DatabaseManager.kProfileDBName) { (data, error) in
            if error == nil{
                if let jsonData = data, jsonData.count > 0{
                    if let userData = Mapper<UserData>().map(JSON: data?.first ?? [:]){
                        UserDefaultsCustom.saveUserData(userData: userData)
                    }
                    self.view?.configureUserName()
                }else{
                    apiCallToGetUserProfile()
                }
            }else{
                apiCallToGetUserProfile()
            }
        }
    }
    
    func apiCallToGetUserProfile(){
        ApiHandler.call(apiName: API.Name.profile) { (data:UserDataModel?, error) in
            if error != nil{
                Singleton.showMessage(message: error ?? "", isError: .error)
            } else{
                guard let user_data = data?.response  else{return}
                DatabaseManager.shared.createOrUpdateDocumentForDb(_id: user_data.mobile ?? "", dbName: DatabaseManager.kProfileDBName, json: user_data.toJSON())
                UserDefaultsCustom.saveUserData(userData: user_data)
                self.view?.configureUserName()
            }
        }
    }
    
}
