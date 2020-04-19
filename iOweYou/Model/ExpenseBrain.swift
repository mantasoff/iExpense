//
//  ExpenseBrain.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-29.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation
import Firebase
import Contacts

class ExpenseBrain {
    var expenseArray: [Debt]?
    var db: Firestore
    var onSendFinished: (() -> ())?
    
    init() {
        db = Firestore.firestore()
    }
    
    func refreshExpenseArray() {
        if let currentUser = Auth.auth().currentUser {
            db.collection(K.FStore.expenseCollection).whereField(K.FStore.emailFieldName, isEqualTo: currentUser.email!).order(by: K.FStore.dateFieldName).addSnapshotListener { documentSnapshot, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let documents = documentSnapshot?.documents {
                    self.expenseArray = []
                    for document in documents {
                        let data = document.data()
                        if let expense = data[K.FStore.expenseFieldName] as? String, let recipient = data[K.FStore.recipientFieldName] as? String, let userEmail = data[K.FStore.emailFieldName] as? String, let date = data[K.FStore.dateFieldName] as? TimeInterval {
                            print(data)
                            
                            let description = (data[K.FStore.descriptionFieldName] ?? "") as? String
                            let debt = Debt(userEmail: userEmail, id: document.documentID, name: recipient, debt: Decimal(string: expense) ?? 0, date: Decimal(date / 3600), description: description)
                            self.expenseArray?.append(debt)
                        }
                    }
                }
                
                if self.onSendFinished != nil {
                    self.onSendFinished!()
                }
                print("Snapshot Running")
            }
        }
        
    }
    
    func sendExpenseToFirestore(expense: Debt,  cb: @escaping (() -> ()?)) {
        if Auth.auth().currentUser == nil {
            print("The user has not logged in")
            return
        }

        db.collection(K.FStore.expenseCollection).addDocument(data: [K.FStore.emailFieldName: Auth.auth().currentUser!.email!,K.FStore.recipientFieldName: expense.name, K.FStore.expenseFieldName: "\(expense.debt)", K.FStore.dateFieldName: Date().timeIntervalSince1970, K.FStore.descriptionFieldName: expense.description ?? ""]) { (error) in
            if error != nil {
                print(error!)
                return
            }
            
            if self.onSendFinished != nil {
                self.onSendFinished!()
            }
            
            cb()
        }
    }
    
    func deleteExpenseByID(_ id: String?) {
        if Auth.auth().currentUser == nil {
            print("The user has not logged in")
            return
        }
        
        if id == nil {
            print("Error: No ID defined")
            return
        }
        
        db.collection(K.FStore.expenseCollection).document(id!).delete() { err in
            if err != nil {
                print(err!)
                return
            }
        }
    }
}
