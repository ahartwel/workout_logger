//
//  SwarmCell.swift
//  SwarmApp
//
//  Created by Gary Herman on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit

class SwarmCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var height : CGFloat {
        get { return 60.0 }
    }
    
    func populate( with swarm : Swarm ) {
    }
    
}
