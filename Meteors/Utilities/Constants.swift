//
//  Constants.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let meteorsFetchingURL = "https://data.nasa.gov/resource/y77d-th95.json"
    
    static let apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    static let yearDateFormat = "yyyy"
    static let apiDefaultYear = "0001-01-01T00:00:00.000" // for Elements without year
    
    static let meteorTableViewCellIdentifier = "meteorCell"
    static let meteorMapViewControllerIdentifier = "meteorMapVC"
    
    static let nameAttributeName = "name"
    static let idAttributeName = "id"
    static let nameTypeAttributeName = "nametype"
    static let recclassAttributeName = "recclass"
    static let massAttributeName = "mass"
    static let fallAttributeName = "fall"
    static let yearAttributeName = "year"
    static let reclatAttributeName = "reclat"
    static let reclongAttributeName = "reclong"
    static let geolocationAttributeName = "geolocation"
    
    static let apiCalledUserDefaultsKey = "API_ONCE_CALLED"
    
    static let meteorCoreDataEntity = "MeteorEntity"
    
}
