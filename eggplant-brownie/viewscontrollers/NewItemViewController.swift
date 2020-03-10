//
//  NewItemViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Giácomo Simões on 31/12/19.
//  Copyright © 2019 Simoes. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var caloriesField: UITextField!
    
    let delegate : AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate){
        self.delegate = delegate
        super.init(nibName: "NewItemViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        let name = nameField.text
        let calories = Double(caloriesField.text ?? "0.0")
        
        let item = Item(name: name!, calories: calories!)
        
        delegate?.addNew(item: item)
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
}
