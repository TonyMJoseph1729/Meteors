//
//  MeteorEntity+CoreDataProperties.swift
//  
//
//  Created by Tony on 19/02/2020.
//
//

import Foundation
import CoreData


extension MeteorEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeteorEntity> {
        return NSFetchRequest<MeteorEntity>(entityName: "MeteorEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var nametype: String?
    @NSManaged public var recclass: String?
    @NSManaged public var mass: String?
    @NSManaged public var fall: String?
    @NSManaged public var year: String?
    @NSManaged public var reclong: String?
    @NSManaged public var reclat: String?
    @NSManaged public var geolocation: String?

}
