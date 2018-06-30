//
//  ViewController.swift
//  Fate Twist
//
//  Created by Eduard Caziuc on 15/06/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var startAdventureButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func animateView(forSeconds seconds: Double) {
        UIView.animate(withDuration: seconds) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            
            do {
                if let name = userNameTextField.text {
                    if name == "" {
                        startAdventureButton.wiggle()
                        throw AdventureError.nameNotProvided
                        
                    } else {
                        guard let pageController = segue.destination as? PageController else { return }
                        
                        pageController.page = Adventure.story(withName: name)
                    }
                }
            } catch AdventureError.nameNotProvided {
                
                let alertController = UIAlertController(title: "Name Not Provided", message: "Please enter your name to start the story", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                present(alertController, animated: true, completion: nil)
            }
            catch let error {
                fatalError("\(error.localizedDescription)")
            }
            
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
        let frame = keyboardFrame.cgRectValue
            textFieldBottomConstraint.constant = frame.size.height
            
            animateView(forSeconds: 0.6)
    }
            
        }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        textFieldBottomConstraint.constant = 20
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

