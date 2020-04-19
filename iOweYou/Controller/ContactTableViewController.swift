//
//  ContactTableViewController.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-04-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import Contacts

class ContactTableViewController: UITableViewController {
    var contactBrain: ContactBrain?
    var onSelectionMade: ((_ contact: CNContact) -> ())?
    var selectedContact: CNContact?
    override func viewDidLoad() {
        super.viewDidLoad()
        contactBrain = ContactBrain()
        contactBrain?.onContactsFetched = refreshTableData
        contactBrain?.fetchContacts()
        tableView.register(UINib(nibName: K.cell.contactNibName, bundle: nil), forCellReuseIdentifier: K.cell.contactCellName)
    }
    
    // MARK: - Table View Actions
    @IBAction func onSelectButtonPressed(_ sender: UIBarButtonItem) {
        print("Select Pressed")
        if selectedContact == nil {
            return
        }
        
        if onSelectionMade != nil {
            onSelectionMade!(selectedContact!)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactBrain?.contacts.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cell.contactCellName, for: indexPath) as! ContactTableViewCell
        if contactBrain == nil {
            contactBrain = ContactBrain()
            print("Contact Brain not initialized")
        }
        
        let contact = contactBrain?.contacts[indexPath.row]
        cell.nameLabel.text = "\(contact?.givenName ?? "")"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContact = contactBrain?.contacts[indexPath.row]
    }
    
    private func refreshTableData() {
        tableView.reloadData()
    }
}
