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
    
    
    
    
    var liste                               =     [Item]()
    var itemName: [NSManagedObject]         =     []
    var itemselect : Item!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowItemViewController"){
            
            let destVC                  = segue.destination as! ShowItemViewController
            
            destVC.texteTitre           =   itemselect.message
            destVC.itemEdit             =   itemselect
            destVC.itemPhoto            =   UIImage(data:itemselect.photo!,scale:1.0)
            destVC.itemdatecreation     =   itemselect.datecreation
            destVC.itemdatemodification =   itemselect.datemodification
            destVC.itemcategory         =   itemselect.category
            destVC.itemdescription      =   itemselect.descriptionitem
            
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate  =   self
        
        let appDelegate     =   UIApplication.shared.delegate as! AppDelegate
        let context         =   appDelegate.persistentContainer.viewContext
      
        do {
            try context.save()
            print("context saved")
        }
        
        catch let error as NSError {
            print("Could not save the database : \(error)")
        }
        
        let fetchRequest: NSFetchRequest<Item> = NSFetchRequest<Item>(entityName: "Item")
        
        do {
            let results  = try context.fetch(fetchRequest)
            liste        = results
        }
            
        catch let error as NSError {
            print("Could not fetch : \(error)")
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemViewTableCell {
        
        let cell            =   tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! ItemViewTableCell
        let item            =   liste[indexPath.row]
        cell.item           =   item
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let cell        =   tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! ItemViewTableCell
        let item        =   liste[indexPath.row]
        itemselect      =   item
        performSegue(withIdentifier: "ShowItemViewController", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell        =    tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! ItemViewTableCell
        let item        =    liste[indexPath.row]
        
        if (item.verif == false){
            
            item.verif              =   true
            cell.accessoryType      =   item.verif ? .checkmark : .checkmark
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
            
            let appDelegate     = UIApplication.shared.delegate as! AppDelegate
            let context         = appDelegate.persistentContainer.viewContext
            context.delete(liste.remove(at: indexPath.row))
            
            do {
                try context.save()
                print("context saved")
            }
                
            catch let error as NSError {
                print("Could not save the database : \(error)")
            }
            
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest<Item>(entityName: "Item")
            
            do {
                let fetchedResults = try context.fetch(fetchRequest)
                let results = fetchedResults as! [NSManagedObject]
                liste=results as! [Item]
            }
                
            catch let error as NSError{
                print("Could not fetch : \(error)")
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
                var predicate : NSPredicate=NSPredicate()
                
                predicate           =   NSPredicate(format: "title contains[c]'\(searchText)'")
                let appDelegate     =   UIApplication.shared.delegate as! AppDelegate
                let context         =   appDelegate.persistentContainer.viewContext
                let fetchRequest    =   NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                
                fetchRequest.predicate=predicate
                
                do {
                    liste           =   try context.fetch(fetchRequest) as! [Item]
                }
                    
                catch{
                    print("erreur")
                }
                
                tableView.reloadData()
                
            }
            
            tableView.reloadData()
        }
    }
    
}
