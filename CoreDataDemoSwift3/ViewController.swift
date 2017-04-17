//
//  ViewController.swift
//  CoreDataDemoSwift3
//
//  Created by Infoicon on 05/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // #pragma mark - Core Data Helper
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItemNames = ["Apples", "Milk", "Bread", "Cheese", "Sausages", "Butter", "Orange Juice", "Cereal", "Coffee", "Eggs", "Tomatoes", "Fish"] as NSArray
       DatabaseManager.sharedInstance.insert(arrayObject: newItemNames)
        var array = DatabaseManager.sharedInstance.fetch()
        let family = array[0]
        print(array)
        DatabaseManager.sharedInstance.delete(record: family)
        array = DatabaseManager.sharedInstance.fetch()
        print(array)
        DatabaseManager.sharedInstance.insert(arrayObject: ["Raj"])
        array = DatabaseManager.sharedInstance.fetch()
        print(array)
        DatabaseManager.sharedInstance.deleteAll()
        array = DatabaseManager.sharedInstance.fetch()
        print(array)
    }

   
    
}

