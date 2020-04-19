//
//  LoginViewController.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        if let userName = userNameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: userName, password: password) { (authDataResult, error) in
                if error != nil {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error?.localizedDescription
                    return
                }
                
                self.performSegue(withIdentifier: K.segues.loginToDebts, sender: self)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
