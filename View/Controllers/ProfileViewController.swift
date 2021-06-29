//
//  ProfileViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 14.04.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    static var user : User?
    
    var username : String!
    var email : String!
    var birthday : String!
    private var date : Date!
    static var changedDate : String?
    
    private var profilePresenter : ProfilePresenter?
    
    @IBOutlet var subscribe: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        initializeProfile()
    }
    
    private func initializeProfile(){
        profilePresenter = ProfilePresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profilePresenter?.checkSubscription(ProfileViewController.getUserId())
    }
    
    private func setUpData(){
        
        guard let user = ProfileViewController.user else{
            print("... setUpData user is nil")
            return
        }
        if let username = user.username{
            usernameLabel.text = "username : \(username)"
        }
        if let email = user.email {
            emailLabel.text = "email : \(email)"
        }
        if let birthday = user.birthDate {
            birthdayLabel.text = "birthday : \(stringCuter(mySubstring: birthday, endIndex: -19))"
        }
        //print(",,,,\(user.subscribed)  \(user.userId)")
        
//            subscribe.text = "\(subscribe)"
        
    }
    @IBAction func logoutAction(_ sender: Any) {
        
        ProfileViewController.user = nil
        
    }
    
    static public func getUserId() -> Int {
    
        if let id = ProfileViewController.user?.userId {
        return id
        }else{
            return 1
        }
    }
    
}

extension ProfileViewController : ProfilePresenterDelegate{
    func getSubscriptionDate(_ date: Date) {
        self.date = date
        guard let datee = self.date else {
            return
        }
        
        var mySubstring = ("\(datee)")
        
        mySubstring = stringCuter(mySubstring: mySubstring,endIndex: -15)
        subscribe.text = "subscribe till : \(mySubstring)"
    }
    
    private func stringCuter(mySubstring : String , endIndex : Int) -> String{
        let start = mySubstring.index(mySubstring.startIndex, offsetBy: 0)
        let end = mySubstring.index(mySubstring.endIndex, offsetBy: endIndex)
        let range = start..<end
        return String(mySubstring[range])
    }
}
