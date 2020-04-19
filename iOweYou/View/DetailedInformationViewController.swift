//
//  DetailedInformationViewController.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-04-19.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class DetailedInformationViewController: UIViewController {

    @IBOutlet weak var recipientInformationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    var expense: Debt?
    var expenseBrain: ExpenseBrain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = K.Titles.detailedInformationTitle
        if expense != nil {
            recipientInformationLabel.text = expense!.name
            descriptionLabel.text = expense?.description
            expenseLabel.text = "\(expense!.debt) Eur"
            let date = NSDate(timeIntervalSince1970: expense!.date)
            dateLabel.text = dateToString(date)
        }
    }

    @IBAction func deleteExpensePressed(_ sender: UIButton) {
        if expenseBrain != nil , expense != nil, expense!.id != nil {
            expenseBrain?.deleteExpenseByID(expense?.id, cb: onDeletionFinished)
        }
    }
    
    func setExpenseInformation(_ expense: Debt) {
        self.expense = expense
    }
    
    private func onDeletionFinished() {
        navigationController?.popViewController(animated: true)
    }
    
    private func dateToString(_ dateVar: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeZone = .current
        
        return formatter.string(from: dateVar as Date)
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
