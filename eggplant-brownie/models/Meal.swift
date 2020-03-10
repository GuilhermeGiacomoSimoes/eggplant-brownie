//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 17/12/19.
//  Copyright © 2019 Simoes. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding {
    let name: String
    let happiness: Int
    var items = Array<Item>()
    
    init(name: String, happiness: Int){
        self.name = name
        self.happiness = happiness
    }
    
    func allCalories() -> Double {
        var total = 0.0
        for i in items {
            total += i.calories
        }
        
        return total
    }
    
    func details() -> String {
        var message = "Happinesss: \(self.happiness)"
        
        for item in self.items {
            message += "\n * \(item.name) - calories: \(item.calories)"
        }
        
        return message
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.happiness, forKey: "happiness")
        aCoder.encode(self.items, forKey: "items")
    }
    
    required init(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
    }
}
