//
//  MeteorTableViewCell.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class MeteorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setLabels(_ meteor: Meteor) {
        self.nameLabel.text = meteor.name
        self.massLabel.text = Utilities().labelTextForMass(meteor.mass!)
        self.yearLabel.text = String(Utilities().yearFromString(meteor.year ?? Constants.apiDefaultYear))
    }
    
}
