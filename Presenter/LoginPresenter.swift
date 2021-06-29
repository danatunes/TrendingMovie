//
//  LoginPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

typealias LoginHandler = ((String) -> ())

protocol LoginPresenterDelegate : NSObjectProtocol{
    
}

class LoginPresenter {
    
    weak var controller : LoginPresenterDelegate? = nil
    
    init(_ controller : LoginPresenterDelegate) {
        self.controller = controller
    }
    
    func login (login : Login, completionHandler: @escaping LoginHandler){
        
        APIManager.shareInstance.callingLoginAPI(login: login) { (result) in
            
            switch result {
            case .success(let json):
                
                //print(json as AnyObject)
                
                let username = (json as AnyObject).value(forKey: "username") as! String
                let email = (json as AnyObject).value(forKey: "email") as! String
                let birthDate = (json as AnyObject).value(forKey: "birthDate") as! String
                let role = (json as AnyObject).value(forKey: "role") as AnyObject
                let name = role.value(forKey: "name") as! String
                let userId = (json as AnyObject).value(forKey: "id") as! Int
                let subscribed = (json as AnyObject).value(forKey: "subscribed") as? Bool
                
//                print("... \(name)")
                let userRole = Role(name: name)
//                print("... \(userRole.name)")
                let user = User(userId: userId, username: username, email: email, birthDate: birthDate, role: userRole, subscribed: subscribed ?? false)
                
                ProfileViewController.user = user
                
                completionHandler(" ")
                    
            case .failure(let error):
                print("... \(error)")
              
                let message = self.clearMessage(message: "\(error)")
                completionHandler(message)
            }
        }
        
    }
    
    private func clearMessage(message : String) ->String {
        let start = message.index(message.startIndex, offsetBy: 17)
        let end = message.index(message.endIndex, offsetBy: -2)
        let range = start..<end
        return String(message[range])
    }
    
}
