//
//  ExpenseTableViewCell.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-03-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var deletionButton: UIButton!
    var id: String?
    var onDeletionEvent: ((_ id: String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        if onDeletionEvent != nil, id != nil {
            onDeletionEvent!(id!)
        }
    }
}
