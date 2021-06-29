//
//  ProfilePresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol ProfilePresenterDelegate : NSObjectProtocol {
    func getSubscriptionDate(_ date : Date)
}

class ProfilePresenter {
    
    weak var controller : ProfilePresenterDelegate! = nil
    
    init(_ controller : ProfilePresenterDelegate) {
        self.controller = controller
    }
    
    func checkSubscription(_ userId : Int){
        APIManager.shareInstance.checkSubscriptionDate(userId) { (date) in
           
            let date = Date(timeIntervalSince1970: (Double(date) / 1000.0))
            self.controller.getSubscriptionDate(date)
        }
    }
    
}
