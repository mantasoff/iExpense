//
//  DebtsViewController.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import Firebase

class DebtsViewController: UIViewController {
    var debtArray: [Debt] = []
    var db: Firestore?
    var expenseBrain: ExpenseBrain?
    var settleExpense: Bool = false
    var selectedIndex: Int?
    @IBOutlet weak var expenseTableView: UITableView!
    
    @IBOutlet weak var debtTableVIew: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.setHidesBackButton(false, animated: animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        debtTableVIew.dataSource = self
        debtTableVIew.register(UINib(nibName: K.cell.nibName, bundle: nil), forCellReuseIdentifier: K.cell.reusableCellName)
        debtTableVIew.delegate = self
        db = Firestore.firestore()
        expenseBrain = ExpenseBrain()
        expenseBrain?.onSendFinished = refreshData
        expenseBrain?.refreshExpenseArray()
    }
    
    @IBAction func onLogOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func onSettleExpensePressed(_ sender: UIButton) {
        settleExpense = !settleExpense
        expenseTableView.reloadData()
    }
    private func refreshData() {
        self.debtTableVIew.reloadData()
        print("Refreshed")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.expensesToAdd {
            if let AddExpensesViewController = segue.destination as? AddExpenseViewController {
                AddExpensesViewController.expenseBrain = expenseBrain
            }
        }
        if segue.identifier == K.segues.expenseToDetailed {
            if let detailedInformationViewController = segue.destination as? DetailedInformationViewController, expenseBrain != nil, selectedIndex != nil {
                detailedInformationViewController.expenseBrain = expenseBrain
                detailedInformationViewController.expense = expenseBrain?.expenseArray![selectedIndex!]
            }
        }
    }
}

//MARK: - Extension UITAbleViewDataSource
extension DebtsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseBrain?.expenseArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cell.reusableCellName, for: indexPath) as! ExpenseTableViewCell
        if expenseBrain == nil {
            return cell
        }
        if expenseBrain?.expenseArray == nil {
            return cell
        }
        let expense = expenseBrain?.expenseArray![indexPath.row]
        cell.nameLabel.text = expense?.name
        cell.debtLabel.text = "\(expense!.debt) eur"
        cell.id = expense?.id
        cell.onDeletionEvent = expenseBrain?.deleteExpenseByID
        
        if settleExpense {
            cell.deletionButton.isHidden = false
        } else {
            cell.deletionButton.isHidden = true
        }
        
        return cell
    }
}

//MARK: - Extension UITableViewDelegate
extension DebtsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if expenseBrain == nil {
            return
        }
        
        if expenseBrain?.expenseArray == nil {
            return
        }
        
        if let _ = expenseBrain?.expenseArray![indexPath.row] {
            selectedIndex = indexPath.row
            performSegue(withIdentifier: K.segues.expenseToDetailed, sender: self)
        }
    }
}
