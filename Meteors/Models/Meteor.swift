//
//  Meteor.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit
import CoreLocation

struct Meteor: Codable, Equatable {
    static func == (lhs: Meteor, rhs: Meteor) -> Bool {
        return true
    }
    
    let name: String?
    let id: String?
    let nametype: String?
    let recclass: String?
    let mass: String?
    let fall: String?
    let year: String?
    let reclat: String?
    let reclong: String?
    let geolocation: Location?
}

struct Location: Codable {
    let type: String?
    let coordinates: [CLLocationDegrees]?
    
}
