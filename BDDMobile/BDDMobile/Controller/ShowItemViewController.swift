//
//  ShowItemViewController.swift
//  BDDMobile
//
//  Created by lpiem on 11/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import CoreData
var liste=[Category]()

class ShowItemViewController : UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    
    
    /*UIPickerViewDataSource, UIPickerViewDelegate,*/
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
    var itemcategory : Category!
    
    func numberOfComponents(in ItemCategory: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ ItemCategory: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return liste.count
    }
    
    func pickerView(_ ItemCategory: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        itemcategory = liste[row]
        
    }
    func pickerView(_ ItemCategory: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return liste[row].nomCat!
        
    }
    
    
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
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        do {
            try context.save()
            print("context saved")
        } catch let error as NSError {
            print("Could not save the database : \(error)")
        }
        
        let fetchRequest: NSFetchRequest<Category> = NSFetchRequest<Category>(entityName: "Category")
        do {
            let results = try context.fetch(fetchRequest)
            
            liste = results
            ItemCategory.reloadComponent(0)
            
            if results.count > 0{
                for r in results as! [NSManagedObject]{
                    if let itemName = r.value(forKey: "nomCat") as? String
                    {print (itemName)}
                    
                }
                
            }
        } catch let error as NSError
        { print("Could not fetch : \(error)")
        }
        
        
        
        
        ItemTitle?.text=texteTitre
        ItemDescription?.text=texteTitre
        ItemPhoto.image =  itemPhoto
        ItemDateCreate.text = myStringafd
        ItemDateModif.text  = myStringafd2
        ItemCategory.reloadComponent(0)
        
    }
    
    
}
