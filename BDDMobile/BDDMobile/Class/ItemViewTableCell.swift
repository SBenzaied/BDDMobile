//
//  ItemViewTableCell.swift
//  BDDMobile
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ItemViewTableCell : UITableViewCell {
    
    var item : Item? {
        
        didSet {
            
            let itemValid =  item != nil
            
            checkLabel.text = (itemValid && item!.verif) ? "✔︎" : ""
            messageLabel?.text = item?.message ?? ""
            
            
        }
    }
    
    @IBOutlet weak var checkLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
}
