//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 03/01/20.
//  Copyright © 2020 Simoes. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    let controller: UIViewController
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func show(message: String = "Unexpected error."){
        let details = UIAlertController(title: "Sorry!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Understood", style: UIAlertAction.Style.cancel, handler: nil)
        
        details.addAction(ok)
        
        controller.present(details, animated: true, completion: nil)
    }
    
    
}
