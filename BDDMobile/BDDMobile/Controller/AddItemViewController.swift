//
//  AddItemViewController.swift
//  BDDMobile
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    var liste=[Category]()
     var listeItem=[Item]()
    var categorie : Category?
    var itemName: [NSManagedObject] = []
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageview: UIImageView!
   
    
   
    
    @IBAction func onClickPickImage(_ sender: Any) {
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true){}
        
        
        
    }
    
 @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageview.image=image
            
        }
      self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func ajout(_ sender: Any) {
        
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  
        
        let newItem = Item(context: context)
        newItem.message = label?.text
        newItem.verif = false
        newItem.category = categorie
        
     


      do {
          try context.save()
          print("context saved")


     
    } catch let error as NSError {
     
    print("Could not save the database : \(error)")
        
        }
        
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return liste[row].nomCat!

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return liste.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
     categorie = liste[row]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
            pickerView.reloadComponent(0)
            
            if results.count > 0{
                for r in results as! [NSManagedObject]{
                    if let itemName = r.value(forKey: "nomCat") as? String
                    {print (itemName)}
                    
                }
                
            }
        } catch let error as NSError
        { print("Could not fetch : \(error)")
        }
        
    }
    
    
    
}
