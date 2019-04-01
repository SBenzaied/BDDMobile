//
//  ToDoViewController.swift
//  BDDMobile
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import CoreData


class ToDoViewController : UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    

    
 var liste=[Item]()
    var itemName: [NSManagedObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
    
        // Do any additional setup after loading the view, typically from a nib.

      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        
        do {
            try context.save()
            print("context saved")
        } catch let error as NSError {
            print("Could not save the database : \(error)")
        }
        
        let fetchRequest: NSFetchRequest<Item> = NSFetchRequest<Item>(entityName: "Item")
        do {
            let results = try context.fetch(fetchRequest)
            
            liste = results
            
            if results.count > 0{
                for r in results as! [NSManagedObject]{
                    if let itemName = r.value(forKey: "message") as? String
                    {print (itemName)}
                    
                }
                
            }
        } catch let error as NSError
            { print("Could not fetch : \(error)")
        }
        
    }
        
        
   

        
//    }

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    return liste.count
        return liste.count
    }
    
//    @IBAction func Ajout(_ sender: Any) {
//   
//        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
//        
//        //2. Add the text field. You can configure it however you need.
//        alert.addTextField { (textField) in
//            textField.text = "Some default text"
//        }
//        
//        // 3. Grab the value from the text field, and print it when the user clicks OK.
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//             let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
//          
//             newItem.setValue(textField?.text, forKey: "message")
//            
//             newItem.setValue(false, forKey: "verif")
//            
//            
//            
//            do {
//                try context.save()
//                print("context saved")
//                
//                
//            } catch let error as NSError {
//                print("Could not save the database : \(error)")
//            }
//            
//            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest<Item>(entityName: "Item")
//            do {
//                let fetchedResults = try context.fetch(fetchRequest)
//                let results = fetchedResults as! [NSManagedObject]
//                self.liste=results as! [Item]
//                 self.tableView.reloadData()
//                if results.count > 0{
//                    for r in results as! [NSManagedObject]{
//                        if let itemName = r.value(forKey: "message") as? String
//                        {print (itemName)}
//                        
//                    }
//                    
//                }
//            } catch let error as NSError
//            { print("Could not fetch : \(error)")
//            }
//            
//            
//           
//            print("Text field: \(textField?.text)")
//            
//        }))
//       
//        // 4. Present the alert.
//        self.present(alert, animated: true, completion: nil)
//        
//    }
//    
    
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemViewTableCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! ItemViewTableCell
    let item = liste[indexPath.row]
    cell.item = item
         //cell.textLabel?.text=item.message
       // cell.check.isHidden = !item.verif
    
    //cell.accessoryType = item.verif ? .checkmark : .none
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! ItemViewTableCell
  let item = liste[indexPath.row]

  if (item.verif == false){
      item.verif = true
   cell.accessoryType = item.verif ? .checkmark : .checkmark
           tableView.reloadData()

       }

     else{
           item.verif = false
           cell.accessoryType = item.verif ? .checkmark : .none
         tableView.reloadData()
     }


 
}
    override func tableView(_ tableView: UITableView, commit editingStyle: ItemViewTableCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == ItemViewTableCell.EditingStyle.delete {
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
         //     liste.remove(at: indexPath.row)
             context.delete(liste.remove(at: indexPath.row))
            
            
            
            do {
                try context.save()
                print("context saved")
            } catch let error as NSError {
                print("Could not save the database : \(error)")
            }
            
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest<Item>(entityName: "Item")
            do {
                let fetchedResults = try context.fetch(fetchRequest)
                let results = fetchedResults as! [NSManagedObject]
                liste=results as! [Item]
                if results.count > 0{
                    for r in results as! [NSManagedObject]{
                        if let itemName = r.value(forKey: "message") as? String
                        {print (itemName)}
                        
                    }
                    
                }
            } catch let error as NSError
            { print("Could not fetch : \(error)")
            }
           
       
            
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //    self.searchBar.showsCancelButton = true
    }
        
        
        
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""
        {
            var predicate: NSPredicate=NSPredicate()
            predicate = NSPredicate(format: "title contains[c]'\(searchText)'")
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            fetchRequest.predicate=predicate
            
            do{
                liste=try context.fetch(fetchRequest) as! [Item]
                
            }
            
            catch{print("erreur")}
             tableView.reloadData()
            
        }

        tableView.reloadData()
    }
        
        
     }
  

}
