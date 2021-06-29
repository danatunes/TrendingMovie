//
//  RegistrationPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

typealias RegisterHandler = (([String],Bool) -> ())

protocol RegisterPresenterDelegate : NSObjectProtocol {
    
}

class RegisterPresenter {
    
    weak var controller: RegisterPresenterDelegate? = nil
    
    init(_ controller: RegisterPresenterDelegate) {
        self.controller = controller
    }
    
    func register(user : UserRegistDTO,completion : @escaping RegisterHandler) {
       
        APIManager.shareInstance.callingRegisterAPI(register: user) { (errorStr, isSuccess) in
            
            if isSuccess {
                completion(errorStr, isSuccess)
            }else{
                completion(errorStr,isSuccess)
            }
        }
    }
    
}
