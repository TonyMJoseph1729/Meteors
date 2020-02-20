//
//  Utilities.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class Utilities {
    
    func yearFromString(_ dateSring: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.apiDateFormat
        let date = dateFormatter.date(from: dateSring)
        dateFormatter.dateFormat = Constants.yearDateFormat
        let year = dateFormatter.string(from: date!)
        return Int(year)!
    }
    
    func labelTextForMass(_ mass: String) -> String {
        return "\(mass) gms"
    }
}
