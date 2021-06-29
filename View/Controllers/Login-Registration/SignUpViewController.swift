//
//  SignUpViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.04.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var additionalInfoContent: UIView!
    @IBOutlet weak var subscriptionContent: UIView!
    @IBOutlet weak var viewChangeBtn: UISegmentedControl!
    
    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
               
                button.setImage(UIImage(named:"circle_radio_selected"), for: .selected)
                button.setImage(UIImage(named: "circle_radio_unselected"), for: .normal)
            }
        }
    }
    
    lazy var errorsStr : String = ""
    
    private var month : Int?
    private var registerPresenter : RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeToRegister()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_Subscription")!)
        setUpElements()
    }
    
    func setUpElements(){
        
        additionalInfoContent.isHidden = false
        subscriptionContent.isHidden = true
        
        errorLbl.alpha = 0
        
        Utilities.styleTextField(username)
        Utilities.styleTextField(password)
        Utilities.styleTextField(rePassword)
        Utilities.styleTextField(email)
        Utilities.styleFilledButton(signUp)
        
    }
    
    public func initializeToRegister(){
        registerPresenter = RegisterPresenter(self)
    }
    
    @IBAction private func subscribeAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print("... sender\(sender.titleLabel?.text)" ?? "1")
            self.month = Int(sender.titleLabel?.text ?? "1")
//            self.isSelected = sender.isSelected
            print(sender.isSelected)
        }
        
        // NOTE:- here you can recognize with tag weather it is `Male` or `Female`.
        print(sender.tag)
    }
    
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        if !additionalInfoContent.isHidden {
            additionalInfoContent.isHidden = true
            subscriptionContent.isHidden = false
        }else{
            additionalInfoContent.isHidden = false
            subscriptionContent.isHidden = true
        }
        
    }
    
    @IBAction func loginTap(_ sender: Any) {
        
        print("..... LOGINN")
        
        guard let username = username.text else {
            print("... username nil")
            return
        }
        guard let password = password.text else {
            print("... password nil")
            return
        }
        guard let rePassword = rePassword.text else{
            print("... repassword nil")
            return
        }
        guard let email = email.text else {
            print("... email nil")
            return
        }
        guard let month = month else {
            print("... month nil")
            return
        }
        
        print("..... before dateFormatter")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        print("... \(dateString)")
        
        let subscribe = SubscribeDTO(month: month)

        let regist = UserRegistDTO(user: UserRegistDTO.UserDTO(username: username, password: password, rePassword: rePassword, email: email, birthDate: dateString), subscriptionDto: subscribe)
        
        print("||||| \(regist)")
        
        registerPresenter.register(user: regist) { (errorStr, isSuccess) in
            self.errorLbl.alpha = 1
            
            self.errorsStr.removeAll()
            
            for item in errorStr{
                self.errorsStr += "\(item) \n"
            }
            
            if isSuccess {
                self.errorLbl.alpha = 1
                self.errorLbl.textColor = .green
                self.errorLbl.numberOfLines = 0
                self.errorLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.errorLbl.text = self.errorsStr
                self.navigationController?.popViewController(animated: true)
            }else{
                self.errorLbl.alpha = 1
                self.errorLbl.textColor = .red
                self.errorLbl.numberOfLines = 0
                self.errorLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.errorLbl.text = self.errorsStr
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        print("..... not be dismissed")
    }
}


extension SignUpViewController : RegisterPresenterDelegate{
    
}




extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.adjustsImageWhenHighlighted = false
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
