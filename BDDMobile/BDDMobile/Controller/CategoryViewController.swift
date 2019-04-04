//
//  CategoryViewController.swift
//  BDDMobile
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController{
    
    var liste=[Category]()
    var itemName: [NSManagedObject] = []
    
    
    
    
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
    
    
    
    @IBAction func addCategory(_ sender: Any) {
        
        
        
        
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newItem = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context)
            
            newItem.setValue(textField?.text, forKey: "nomCat")
            
     
            
            
            
            do {
                try context.save()
                print("context saved")
                
                
            } catch let error as NSError {
                print("Could not save the database : \(error)")
            }
            
            let fetchRequest: NSFetchRequest<Category> = NSFetchRequest<Category>(entityName: "Category")
            do {
                let fetchedResults = try context.fetch(fetchRequest)
                let results = fetchedResults as! [NSManagedObject]
                self.liste=results as! [Category]
                self.tableView.reloadData()
                if results.count > 0{
                    for r in results as! [NSManagedObject]{
                        if let itemName = r.value(forKey: "nomCat") as? String
                        {print (itemName)}
                        
                    }
                    
                }
            } catch let error as NSError
            { print("Could not fetch : \(error)")
            }
            
            
            
            print("Text field: \(textField?.text)")
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func back(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    
    
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //    return liste.count
        return liste.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoryItem {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell") as! CategoryItem
        let item = liste[indexPath.row]
        cell.item = item
        //cell.textLabel?.text=item.message
        // cell.check.isHidden = !item.verif
        
        //cell.accessoryType = item.verif ? .checkmark : .none
        
        
        return cell
    }
    
}
