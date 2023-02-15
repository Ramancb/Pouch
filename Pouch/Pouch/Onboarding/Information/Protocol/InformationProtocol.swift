//
//  InformationProtocol.swift
//  Pouch
//
//  Created by Raman choudhary on 15/02/23.
//

import Foundation


protocol InformationPresenterProtocol{
  var view: InformationViewProtocol? {get set}
}

protocol InformationViewProtocol{
    var presenter:InformationPresenterProtocol? { get set }
    
}
