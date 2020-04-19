//
//  AddExpenseViewController.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-21.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import Firebase
import Contacts

class AddExpenseViewController: UIViewController {
    @IBOutlet weak var recipientNameTextField: UITextField!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var expenseBrain: ExpenseBrain?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        if (recipientNameTextField.text == nil) || (expenseTextField.text == nil) {
            print("One of the texts is nil")
            return
        }
        
        let expense = Decimal(string: expenseTextField.text!)
        if expense == nil {
            print("Expense is not a number")
            return
        }
        
        if Auth.auth().currentUser != nil {
            let debt = Debt(userEmail: Auth.auth().currentUser!.email!,
                            id: nil,
                            name: recipientNameTextField.text!,
                            debt: expense!,
                            date: Date().timeIntervalSince1970,
                            description: descriptionTextField.text ?? "")
            expenseBrain?.sendExpenseToFirestore(expense: debt, cb: onSendFinished)
        }
        
        
    }
    
    @IBAction func contactButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segues.addToContact, sender: self)
    }
    
    private func onSendFinished() {
        navigationController?.popViewController(animated: true)
    }
    
    private func onContactSelection(_ contact: CNContact) {
        recipientNameTextField.text = contact.givenName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.addToContact {
            let contactTableViewController = segue.destination as! ContactTableViewController
            
            contactTableViewController.onSelectionMade = onContactSelection
        }
    }
}

extension AddExpenseViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.restorationIdentifier == K.textFields.expenseFieldName, textField.text != nil  {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }

            let newText = oldText.replacingCharacters(in: r, with: string)
            let isNumeric = newText.isEmpty || (Double(newText) != nil)
            let numberOfDots = newText.components(separatedBy: ".").count - 1

            let numberOfDecimalDigits: Int
            if let dotIndex = newText.firstIndex(of: ".") {
                numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }

            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        }
        return true
    }
}
