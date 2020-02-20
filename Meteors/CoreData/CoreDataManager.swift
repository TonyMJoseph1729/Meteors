//
//  CoreDataManager.swift
//  Meteors
//
//  Created by Tony on 20/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MeteorsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // save data to coredata
    func save(meteor: Meteor)-> Meteor? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let meteorEntity =
            NSEntityDescription.entity(forEntityName: Constants.meteorCoreDataEntity,
                                       in: managedContext)!
        let newMeteor = NSManagedObject(entity: meteorEntity,
                                        insertInto: managedContext)
        newMeteor.setValue(meteor.name, forKey: Constants.nameAttributeName)
        newMeteor.setValue(meteor.id, forKey: Constants.idAttributeName)
        newMeteor.setValue(meteor.nametype, forKey: Constants.nameTypeAttributeName)
        newMeteor.setValue(meteor.recclass, forKey: Constants.recclassAttributeName)
        newMeteor.setValue(meteor.mass, forKey: Constants.massAttributeName)
        newMeteor.setValue(meteor.fall, forKey: Constants.fallAttributeName)
        newMeteor.setValue(meteor.year, forKey: Constants.yearAttributeName)
        newMeteor.setValue(meteor.reclat, forKey: Constants.reclatAttributeName)
        newMeteor.setValue(meteor.reclong, forKey: Constants.reclongAttributeName)
        
        let jsonData = try! JSONEncoder().encode(meteor.geolocation)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        newMeteor.setValue(jsonString, forKey: Constants.geolocationAttributeName)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
        return meteor
    }
    
    //fetch offline data saved
    func fetchMeteorsFromCoreData() -> [Meteor] {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.meteorCoreDataEntity)
        
        var retrievedCoreDataObjects = [Meteor]()
        do {
            let retrievedArray = try managedContext.fetch(fetchRequest)
            for meteor in retrievedArray {
                let meteorObject = CoreDataManager().meteorModelFrom(meteor)
                retrievedCoreDataObjects.append(meteorObject)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retrievedCoreDataObjects
        
    }
    
    // parse coredata to meteor model
    func meteorModelFrom(_ meteor: NSManagedObject) -> Meteor {
        let name = meteor.value(forKey: Constants.nameAttributeName) as! String
        let id = meteor.value(forKey: Constants.idAttributeName) as! String
        let nameType = meteor.value(forKey: Constants.nameTypeAttributeName) as! String
        let recclass = meteor.value(forKey: Constants.recclassAttributeName) as! String
        let mass = meteor.value(forKey: Constants.massAttributeName) as! String
        let fall = meteor.value(forKey: Constants.fallAttributeName) as! String
        let year = meteor.value(forKey: Constants.yearAttributeName) as! String
        let reclat = meteor.value(forKey: Constants.reclatAttributeName) as! String
        let reclong = meteor.value(forKey: Constants.reclongAttributeName) as! String
        
        let geolocationString = meteor.value(forKey: Constants.geolocationAttributeName) as! String
        let geojsonData = Data(geolocationString.utf8)
        let geolocation = try? JSONDecoder().decode(Location.self, from: geojsonData)
        let meteorElement = Meteor(name: name, id: id, nametype: nameType, recclass: recclass, mass: mass, fall: fall, year: year, reclat: reclat, reclong: reclong, geolocation: geolocation)
        
        return meteorElement
    }
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.meteorCoreDataEntity)
        let objs = try! CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            CoreDataManager.sharedManager.persistentContainer.viewContext.delete(obj)
        }
        
        try! CoreDataManager.sharedManager.persistentContainer.viewContext.save()
    }
}



