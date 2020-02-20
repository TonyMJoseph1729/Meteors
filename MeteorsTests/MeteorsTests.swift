//
//  MeteorsTests.swift
//  MeteorsTests
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import XCTest

class MeteorsTests: XCTestCase {

    let listVC = MeteorsListViewController()
    let mapVC = MeteorMapViewController()
    let coreDataManager = CoreDataManager.sharedManager
    
    // dummy values for test
    let meteor1 = Meteor(name: "Aachen", id: "1", nametype: "Valid", recclass: "L5", mass: "21", fall: "Fell", year: "2012-01-01T00:00:00.000", reclat: "50.775000", reclong: "6.083330", geolocation: Location(type: "Point", coordinates: [6.08333,50.775]))
    
    let meteor2 = Meteor(name: "Aarhus", id: "2", nametype: "Valid", recclass: "H6", mass: "720", fall: "Fell", year: "1951-01-01T00:00:00.000", reclat: "56.183330", reclong: "10.233330", geolocation: Location(type: "Point", coordinates: [10.23333,56.18333]))
    
    let meteor3 = Meteor(name: "Abee", id: "6", nametype: "Valid", recclass: "EH4", mass: "107000", fall: "Fell", year: "1952-01-01T00:00:00.000", reclat: "54.216670", reclong: "-113.000000", geolocation: Location(type: "Point", coordinates: [-113,54.21667]))

    func testingYearFromString() {
        let yearString = "1880-01-01T00:00:00.000"
        let year = Utilities().yearFromString(yearString)
        XCTAssertEqual(year, 1880)
    }
    
    func testingFilterFunction() {
        let filteredMeteor = listVC.filterMeteorsArray([meteor1,meteor2,meteor3])
        XCTAssertEqual(1, filteredMeteor.count)
    }
    
    func testingLabelTestforMass() {
        let massLabelText = Utilities().labelTextForMass("1589")
        XCTAssertEqual("1589 gms", massLabelText)
    }
    
    func testingSort() {
        let sortedArray = listVC.sortFilteredArray([meteor1,meteor2,meteor3])
        XCTAssertEqual(sortedArray, [meteor3,meteor2,meteor1])
    }
    
    
        //test if NSPersistentContainer(the actual core data stack) initializes successfully
        func test_coreDataStackInitialization() {
            let coreDataStack = coreDataManager.persistentContainer
            
            XCTAssertNotNil( coreDataStack )
        }
    
    func testingSaveCoredata() {
        
        let m1 = coreDataManager.save(meteor: meteor1)
        XCTAssertNotNil(m1)
        let m2 = coreDataManager.save(meteor: meteor2)
        XCTAssertNotNil(m2)
        let m3 = coreDataManager.save(meteor: meteor3)
        XCTAssertNotNil(m3)
        
    }
    
    func testingFetchingCoreData() {
        
        let results = coreDataManager.fetchMeteorsFromCoreData()
        XCTAssertEqual(results.count, 3)
    }
    
    func test_flushData() {
        coreDataManager.flushData()
        XCTAssertEqual(coreDataManager.fetchMeteorsFromCoreData().count, 0)
    }

    }
    

