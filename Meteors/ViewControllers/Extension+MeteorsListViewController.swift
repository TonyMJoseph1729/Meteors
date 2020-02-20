//
//  Extension+MeteorsListViewController.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Tableview data source
extension MeteorsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meteorsArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meteor = meteorsArray[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.meteorTableViewCellIdentifier, for: indexPath) as! MeteorTableViewCell
        cell.setLabels(meteor)
        return cell
    }
    
}

//MARK:- Tableview delegate
extension MeteorsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meteor = meteorsArray[indexPath.section]
        let meteorMapVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.meteorMapViewControllerIdentifier) as! MeteorMapViewController
        meteorMapVC.meteor = meteor
        self.navigationController?.pushViewController(meteorMapVC, animated: true)
        
    }
}
