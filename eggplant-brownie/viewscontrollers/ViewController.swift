//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 17/12/19.
//  Copyright © 2019 Simoes. All rights reserved.
//

import UIKit

protocol AddAnItemDelegate {
    func addNew(item: Item)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var happinessField: UITextField!
    @IBOutlet weak var tableView: UITableView?
    
    var delegate:MealsTableViewController?
    
    var items = Array<Item>()
    
    var selected = Array<Item>()
    
    func getUserDir() -> String{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return userDir[0] as String
    }
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("showNewItem")))
        navigationItem.rightBarButtonItem = newItemButton
        
        let dir = getUserDir()
        let archive = "\(dir)/eggplant-brownie-items"
        
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: archive) {
            items = loaded as! Array
        }
    }
    
    @IBAction func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        } else {
            Alert(controller: self).show(message: "")
        }
    }
    
    @IBAction func add(){
        if let meal = getMealFromForm() {
            if let meals = delegate {
                meals.add(meal: meal)
                
                if let navigation = self.navigationController {
                    navigation.popViewController(animated: true)
                } else {
                    Alert(controller: self).show(message: "Unexpected error, but the meal was added.")
                }
                
                return
            }
        }
        Alert(controller: self).show()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if(cell?.accessoryType == UITableViewCell.AccessoryType.none){
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selected.append(items[indexPath.row])
            
        } else {
            cell?.accessoryType = UITableViewCell.AccessoryType.none
            
            if let position = find(elements: selected, toFind: items[indexPath.row]) {
                
                selected.remove(at: position)
            }
        }
    }
    
    private func find(elements: Array<Item>, toFind:Item) -> Int? {
        let max = elements.count - 1
        
        for i in 0...max {
            if toFind == elements[i] {
                return i
            }
        }
        
        return nil
    }
    
    func addNew(item: Item) {
        items.append(item)
        
        let dir = getUserDir()
        let archive = "\(dir)/eggplant-brownie-items"
        NSKeyedArchiver.archiveRootObject(items, toFile: archive)
        
        if let table = tableView {
            table.reloadData()
        } else {
            Alert(controller: self).show(message: "Unexpected error, but the item was added.")
        }
    }
    
    func getMealFromForm() -> Meal? {
        if nameField == nil || happinessField == nil {
            return nil
        }
        
        let name = nameField.text!
        let happiness = Int(happinessField.text!)
        
        if happiness == nil {
            return nil
        }
        
        let meal = Meal(name: name, happiness: happiness!)
        meal.items = selected
        
        return meal
    }
}

