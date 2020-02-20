//
//  ViewController.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import NVActivityIndicatorView

class MeteorsListViewController: UIViewController {
    
    @IBOutlet weak var meteorsTableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    var meteorsArray = [Meteor]() //the final sorted array displayed
    
    let refreshControl = UIRefreshControl() // for tableview pull to refresh
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
    //fetchData from either URL or coredata
    func fetchData() {
        activityIndicatorView.startAnimating()
        if !UserDefaults.standard.bool(forKey: Constants.apiCalledUserDefaultsKey) {
            UserDefaults.standard.setValue(true, forKey: Constants.apiCalledUserDefaultsKey)
            fetchMeteorsFromURL() //call API only for the first time
        } else {
            reloadTableViewData() // fetch Data from Coredata and display
        }
        
    }
    
    func reloadTableViewData() {
        activityIndicatorView.stopAnimating()
        let coreDataMeteorArray = CoreDataManager.sharedManager.fetchMeteorsFromCoreData()
        meteorsArray = sortFilteredArray(coreDataMeteorArray)
        meteorsTableView.reloadData()
    }
    
    @IBAction func syncButtonTapped(_ sender: Any) {
        fetchMeteorsFromURL()
    }
    
    //filter meteors after 2011
    func filterMeteorsArray(_ meteorsArray: [Meteor]) -> [Meteor] {
        return meteorsArray.filter { Utilities().yearFromString($0.year ?? Constants.apiDefaultYear) >= 2011 }
    }
    
    //sort the array by their mass
    func sortFilteredArray(_ array: [Meteor]) -> [Meteor] {
        return array.sorted (by: {
            guard let mass0 = Float($0.mass!), let mass1 = Float($1.mass!) else { return false }
            return mass0 > mass1
        })
    }
    
    //fetch Meteors From URL for the first time and on pull to refresh
    func fetchMeteorsFromURL() {
        activityIndicatorView.startAnimating()
        APIManager().webservice(url: Constants.meteorsFetchingURL, method: .get, encoding: JSONEncoding.default) { (response) in
            self.refreshControl.endRefreshing()
            
            let decoder = JSONDecoder()
            do {
                if let responseData = response.data {
                    let retrievedMeteorArray = try decoder.decode([Meteor].self, from: responseData)
                    let filteredArray = self.filterMeteorsArray(retrievedMeteorArray)
                    
                    for meteor in filteredArray {
                        if !self.meteorsArray.contains(where: {$0.id == meteor.id}) {
                            _ = CoreDataManager.sharedManager.save(meteor: meteor)
                        }
                    }
                    self.reloadTableViewData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
