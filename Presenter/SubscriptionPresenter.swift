//
//  SubscriptionPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol SubscriptionPresenterDelegate : NSObjectProtocol {
    
    func redirect()
    
}

class SubscriptionPresenter {
    
    weak var controller : SubscriptionPresenterDelegate! = nil
    
    init(_ controller : SubscriptionPresenterDelegate) {
        self.controller = controller
    }
    
    
    func extendSubscription(subscription : SubscribeExtendDTO, completionHandler : @escaping ((String)-> Void)){
        
        APIManager.shareInstance.callingSubscribeAPI(subscribe: subscription) { (newDate) in
            
            if newDate != nil{
                completionHandler(newDate)
                self.controller.redirect()
            }else{
                completionHandler(" ")
            }
        }
        
    }
    
}
