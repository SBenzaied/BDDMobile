//
//  ShowItemViewController.swift
//  BDDMobile
//
//  Created by lpiem on 11/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import CoreData


class ShowItemViewController : UIViewController {
    
    @IBOutlet weak var ItemPhoto: UIImageView!
    @IBOutlet weak var ItemTitle: UILabel?
    @IBOutlet weak var ItemDescription: UITextView?
    @IBOutlet weak var ItemCategory: UIPickerView!
    @IBOutlet weak var ItemDateCreate: UILabel!
    @IBOutlet weak var ItemDateModif: UILabel!
    var texteTitre : String!
    var itemPhoto : UIImage!
    var itemdescription: String!
    var itemdatecreation : Date!
    var itemdatemodification : Date!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
         
         let formatter = DateFormatter()
         // initially set the format based on your datepicker date / server String
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
         let myString = formatter.string(from: itemdatecreation) // string purpose I add here
        let myString2 = formatter.string(from: itemdatemodification)
         // convert your string to date
         let yourDate = formatter.date(from: myString)
        let yourDate2 = formatter.date(from: myString2)
         //then again set the date format whhich type of output you need
         formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
         // again convert your date to string
         let myStringafd = formatter.string(from: yourDate!)
         let myStringafd2 = formatter.string(from: yourDate2!)
         
         
  
        ItemTitle?.text=texteTitre
        ItemDescription?.text=texteTitre
        ItemPhoto=UIImageView(image: itemPhoto)
        ItemDateCreate.text = myStringafd
        ItemDateModif.text  = myStringafd2
    }
    
}
