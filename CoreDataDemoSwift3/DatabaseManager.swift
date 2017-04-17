//
//  DatabaseManager.swift
//  CoreDataDemoSwift3
//
//  Created by Infoicon on 06/04/17.
//  Copyright © 2017 InfoiconTechnologies. All rights reserved.
//

import UIKit
import CoreData


class DatabaseManager: NSObject {
    
    let familyEntity = "Family"
    

    lazy var cdh: CoreDataHelper = {
        let cdh = CoreDataHelper()
        return cdh
    }()
    
    // MARK: - Shared Instance
    
    static let sharedInstance: DatabaseManager = {
        let instance = DatabaseManager()
        // setup code
        return instance
    }()
    
   
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func insert(arrayObject:NSArray){
        NSLog(" ======== Insert ======== ")

        for newItemName in arrayObject {
            let newItem: Family = NSEntityDescription.insertNewObject(forEntityName: familyEntity, into: self.cdh.backgroundContext!) as! Family
            
            newItem.name = newItemName as? String
            NSLog("Inserted New Family for \(newItemName) ")
        }
        
        self.cdh.saveContext(context: self.cdh.backgroundContext!)
    }
    
    func fetch()->[Family]{
        
        //fetch families
        NSLog(" ======== Fetch ======== ")
        var error: NSError? = nil
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: familyEntity)
        
        //   fReq.predicate = NSPredicate(format:"name CONTAINS 'B' ")
        
        // let sorter: NSSortDescriptor = NSSortDescriptor(key: "name" , ascending: false)
        //  fReq.sortDescriptors = [sorter]
        
        fReq.returnsObjectsAsFaults = false
        
        var result: [AnyObject]?
        do {
            result = try self.cdh.managedObjectContext.fetch(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
            print(error ?? "")
        }
        
        var arrayResult=[Family]()
        for resultItem in result! {
            let familyItem = resultItem as! Family
           // NSLog("Fetched Family for \(String(describing: familyItem.name)) ")
           arrayResult.append(familyItem)
        }
        
        return arrayResult
    }
    
    func delete(record:Family){
        
        self.cdh.managedObjectContext.delete(record)
        
        self.cdh.saveContext(context: self.cdh.managedObjectContext)
    }
    
    func deleteAll(){
        
        var error: NSError? = nil
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: familyEntity)
     
        fReq.returnsObjectsAsFaults = false
        
        var result: [AnyObject]?
        do {
            result = try self.cdh.managedObjectContext.fetch(fReq)
        } catch let nserror1 as NSError{
            error = nserror1
            result = nil
            print(error ?? "")
        }
        
        for resultItem in result! {
            let familyItem = resultItem as! Family
            self.cdh.managedObjectContext.delete(familyItem)
   
        }

          self.cdh.saveContext(context: self.cdh.managedObjectContext)
    }
    
}
