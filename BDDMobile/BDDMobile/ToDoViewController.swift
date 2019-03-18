//
//  ToDoViewController.swift
//  BDDMobile
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class ToDoViewController : UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var liste=[Item]()
    var listeTotale=[Item]()
    var recherche=[Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        liste.append(Item(message: "test",verif: true))
        liste.append(Item(message: "Test",verif: false))
        liste.append(Item(message: "MATCH",verif: true))
        listeTotale=liste
        recherche=liste
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! UITableViewCell
        let item = liste[indexPath.row]
        cell.textLabel?.text=item.message
        cell.accessoryType = item.verif ? .checkmark : .none
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell") as! UITableViewCell
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        liste=listeTotale
        recherche = searchText.isEmpty ? liste :
            liste.filter( { $0.message.localizedCaseInsensitiveContains(searchText) })
        liste=recherche
        tableView.reloadData()
    }
    
  
    
    
}
