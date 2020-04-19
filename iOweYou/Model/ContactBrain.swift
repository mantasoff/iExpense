//
//  ContactBrain.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-04-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation
import Contacts

class ContactBrain {
    var contacts: [CNContact] = []
    var onContactsFetched: (() -> ())?
    
    func fetchContacts() {
        print("trying to fetch contacts")
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("failed to request access: \(err)")
                return
            }
            
            if granted {
                print("Access Granted")
                
                let keys = [CNContactGivenNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request) { (contact, stopEnumerating) in
                        self.contacts.append(contact)
                    }
                    
                    if self.onContactsFetched != nil {
                        self.onContactsFetched!()
                    }
                    
                } catch let err {
                    print(err)
                }
                
                
                
            } else {
                print("Access Denied")
                return
            }
            
        }
    }
}
