//
//  ChosenPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol ChosenPresenterDelegate : NSObjectProtocol {
    func fetchMovies(_ movies : [MovieDTO])
}

class ChosenPresenter {
    
    weak var controller : ChosenPresenterDelegate! = nil
    
    init(_ controller : ChosenPresenterDelegate) {
        self.controller = controller
    }
    
    func fetchAllMovies(){
        controller.fetchMovies(CoreDataManager.shared.allMovies())
    }
    
 
    
}
