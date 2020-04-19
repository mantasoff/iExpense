//
//  ContactTableViewCell.swift
//  iOweYou
//
//  Created by Mantas Paškevičius on 2020-04-08.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var onCellSelectedCallback: ((_ name: String) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if let name = nameLabel.text, onCellSelectedCallback != nil {
            onCellSelectedCallback!(name)
        }
    }
    
}
