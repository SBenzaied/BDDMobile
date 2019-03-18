//
//  Item.swift
//  BDDMobile
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation


class Item
{
    var message :String
    var verif   :Bool
    
    init(message: String, verif: Bool=false){
        self.message=message
        self.verif=verif
    }
    
    func toggleChecked (){
        verif = !verif
    }
    
}
