//
//  CategoryItem.swift
//  BDDMobile
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class CategoryItem : UITableViewCell {
    
    var item : Category? {
        
        didSet {
            
            let itemValid =  item != nil
             textLabel?.text = item?.nomCat ?? ""
      
            
            
        }
    }
    
    @IBOutlet weak var textLabelCat: UILabel!
    
}
