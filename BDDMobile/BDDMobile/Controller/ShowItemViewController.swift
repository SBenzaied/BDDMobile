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

class ShowItemViewController : UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var ItemTitleText: UITextField!
    @IBOutlet weak var ItemPhoto: UIImageView!
    @IBOutlet weak var ItemTitle: UILabel?
    @IBOutlet weak var ItemDescription: UITextView?
    @IBOutlet weak var ItemCategory: UIPickerView!
    @IBOutlet weak var ItemDateCreate: UILabel!
    @IBOutlet weak var ItemDateModif: UILabel!
    @IBOutlet weak var Valider: UIButton!
    
    var itemEdit : Item!
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
        let formatter           =   DateFormatter()
        formatter.dateFormat    =   "yyyy-MM-dd HH:mm:ss"
        let datecreaString      =   formatter.string(from: itemdatecreation)
        let datemodifString     =   formatter.string(from: itemdatemodification)
        let dateCrea            =   formatter.date(from: datecreaString)
        let dateModif           =   formatter.date(from: datemodifString)
        formatter.dateFormat    =   "dd-MMM-yyyy HH:mm:ss"
        let dateCreation        =   formatter.string(from: dateCrea!)
        let dateModification    =   formatter.string(from: dateModif!)
        
        
        let appDelegate         = UIApplication.shared.delegate as! AppDelegate
        let context             = appDelegate.persistentContainer.viewContext
        
        
        
        do {
            try context.save()
            print("context saved")
        }
            
        catch let error as NSError {
            print("Could not save the database : \(error)")
        }
        
        let fetchRequest: NSFetchRequest<Category> = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            let results     =   try context.fetch(fetchRequest)
            liste           =    results
            ItemCategory.reloadComponent(0)
        }
            
        catch let error as NSError{
            print("Could not fetch : \(error)")
        }
        
        
        
        
        ItemTitleText?.text     =   texteTitre
        ItemDescription?.text   =   itemdescription
        ItemPhoto.image         =   itemPhoto
        ItemDateCreate.text     =   "Crée le : "+dateCreation
        ItemDateModif.text      =   "Modifié le : "+dateModification
        ItemCategory.reloadComponent(0)
        
    }
    
    
    
    
    @IBAction func ModifierTache(_ sender: Any) {
        
        
        let appDelegate              =   UIApplication.shared.delegate as! AppDelegate
        let context                  =   appDelegate.persistentContainer.viewContext
        let data                     =   (ItemPhoto.image)!.pngData()
        let newItem                  =   itemEdit
        newItem!.message             =   ItemTitleText?.text
        newItem!.descriptionitem     =   ItemDescription!.text
        newItem!.verif               =   false
        newItem!.photo               =   data
        newItem!.datecreation        =   itemdatecreation
        newItem!.datemodification    =   Date()
        newItem!.category            =   itemcategory
        
        
        
        
        do {
            try context.save()
            print("context saved")
            
        }
        catch let error as NSError {
            
            print("Could not save the database : \(error)")
            
        }
        
        
    }
    
    @IBAction func ModifierImage(_ sender: Any) {
        
        let imagePicker             = UIImagePickerController()
        imagePicker.delegate        = self
        imagePicker.sourceType      = .photoLibrary
        imagePicker.allowsEditing   = false
        
        self.present(imagePicker, animated: true){}
        
        
        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image        = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            ItemPhoto.image = image
        }
        else {
            print("marche pas")
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}
