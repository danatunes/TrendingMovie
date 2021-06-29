//
//  LoginViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var loginPresenter : LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        callToLogin()
    }
    
    func setUpElements() -> () {
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }
    
    func callToLogin(){
        loginPresenter = LoginPresenter(self)
    }

    @IBAction func loginTaped(_ sender: Any) {
        
        guard let username = usernameTextField.text else {
            print("... username is nil")
            return
        }
        guard let password = passwordTextField.text else {
            print("... password is nil")
            return
        }
     
        let loginUser = Login(username: username , password: password)
                
        loginPresenter.login(login: loginUser) { (result) in
            if result == " "{
                self.redirectToMain(user: ProfileViewController.user!)
            }else{
                self.errorLabel.textColor = .red
                self.errorLabel.alpha = 1
                self.errorLabel.numberOfLines = 0
                self.errorLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.errorLabel.text = "\(result)"
            }
        }
    }
    
    private func clearMessage(message : String) ->String {
        let start = message.index(message.startIndex, offsetBy: 17)
        let end = message.index(message.endIndex, offsetBy: -2)
        let range = start..<end
        return String(message[range])
    }
    
    private func redirectToMain(user : User) {
        ProfileViewController.user = user
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
          if let navigator = self.navigationController {
               navigator.pushViewController(tabBarController, animated: true)
      }
    }
}

extension LoginViewController : LoginPresenterDelegate{
    
}
