//
//  SubscriptionViewController.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.06.2021.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                
                button.setImage(UIImage(named:"circle_radio_selected"), for: .selected)
                button.setImage(UIImage(named: "circle_radio_unselected"), for: .normal)
            }
        }
    }
    
    private var month : String?
    private var subscriptionPresenter : SubscriptionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePresenter()
    }

    private func initializePresenter(){
        subscriptionPresenter = SubscriptionPresenter(self)
    }
    
    @IBAction private func subscribeAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            self.month = sender.titleLabel?.text
            print(sender.isSelected)
        }
        print(sender.tag)
    }

    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
    
    @IBAction func subscribeBtnAction(_ sender: UIButton) {
        
        let subscribe = SubscribeExtendDTO(month: Int(month ?? "1"), userId: (ProfileViewController.getUserId()))

        subscriptionPresenter?.extendSubscription(subscription: subscribe, completionHandler: { [weak self] (newDate) in
            
                ProfileViewController.changedDate = newDate
            self?.navigationController?.popViewController(animated: true)

            print(".,.,., \(newDate)")
            
        })
    
    }
    
}

extension SubscriptionViewController : SubscriptionPresenterDelegate {
    func redirect() {
    }
}
