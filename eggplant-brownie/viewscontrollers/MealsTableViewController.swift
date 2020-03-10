//
//  MealsTableViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 17/12/19.
//  Copyright © 2019 Simoes. All rights reserved.
//

import UIKit

protocol AddMealDelegate {
    func add(meal: Meal)
}

class MealsTableViewController: UITableViewController, AddMealDelegate {
    var meals = Array<Meal>()
    
    override func viewDidLoad() {
        let dir = getUserDir()
        let archive = "\(dir)/eggplant-brownie-meals"
        
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: archive) {
            self.meals = loaded as! Array
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("showDetails:"))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    func add(meal: Meal){
        meals.append(meal)
            
        let dir = getUserDir()
        let archive = "\(dir)/eggplant-brownie-meals"
        
        NSKeyedArchiver.archiveRootObject(meals, toFile: archive)
        tableView.reloadData()
    }
    
    func getUserDir() -> String {
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return userDir[0] as String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addMeal"){
            let view = segue.destination as? ViewController
            view?.delegate = self
        }
    }
    
    func showDetails(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let cell = recognizer.view as? UITableViewCell
            
            if cell == nil{
                return
            }
            
            let indexPath = tableView.indexPath(for: cell!)
            
            if indexPath == nil{
                return
            }
            
            let row = indexPath!.row
            let meal = meals[row]
            
            RemoveMealController(controller: self).show(meal: meal, handler: {
                action in
                self.meals.remove(at: row)
                self.tableView.reloadData()
            })
        }
    }
}
