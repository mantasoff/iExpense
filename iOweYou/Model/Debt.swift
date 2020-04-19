//
//  Debt.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-21.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation

class Debt {
    var userEmail: String
    var id: String?
    var name: String
    var debt: Decimal
    var date: Decimal
    var description: String?
    
    init(userEmail: String, id: String?, name: String, debt: Decimal, date: Decimal, description: String?) {
        self.userEmail = userEmail
        self.id = id
        self.name = name
        self.debt = debt
        self.date = date
        self.description = description
    }
    
    func getDebt() -> Decimal {
        return debt
    }
    
    func setDebt(_ newDebt: Decimal) {
        debt = newDebt
    }
}
