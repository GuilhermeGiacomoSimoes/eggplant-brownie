//
//  RemoveMealController.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 04/01/20.
//  Copyright © 2020 Simoes. All rights reserved.
//

import Foundation
import UIKit

class RemoveMealController {
    let controller:UIViewController
    init(controller:UIViewController){
        self.controller = controller
    }
   
    func show(meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        //create to modal for view details meal
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: handler)
        
        details.addAction(cancel)
        details.addAction(remove)
        
        controller.present(details, animated: true, completion: nil)
    }
}
