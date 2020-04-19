//
//  Constants.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation

struct K {
    struct segues {
        static let loginToDebts = "loginToDebts"
        static let registerToDebts = "registerToDebts"
        static let expensesToAdd = "expensesToAdd"
        static let addToContact = "addToContact"
        static let expenseToDetailed = "expenseToDetailed"
    }
    struct buttons {
        static let logOut = "Logout"
    }
    struct cell {
        static let reusableCellName = "ReusableCell"
        static let nibName = "ExpenseTableViewCell"
        static let contactCellName = "contactIdentifier"
        static let contactNibName = "ContactTableViewCell"
    }
    struct FStore {
        static let idFieldName = "id"
        static let expenseCollection = "ExpenseCollection"
        static let recipientFieldName = "recipient"
        static let expenseFieldName = "expenseField"
        static let dateFieldName = "date"
        static let emailFieldName = "email"
        static let descriptionFieldName = "description"
    }
    struct textFields {
        static let expenseFieldName = "expenseText"
    }
    struct Titles {
        static let detailedInformationTitle  = "Detailed Information"
    }
}
