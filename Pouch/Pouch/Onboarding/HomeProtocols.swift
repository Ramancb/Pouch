//
//  HomeProtocols.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation

protocol HomeViewProtocol{
    var presenter:HomePresenterProtocol? {get set}
}

protocol HomePresenterProtocol{
    var view:HomeViewProtocol? {get set}
}
