//
//  SwarmCell.swift
//  SwarmApp
//
//  Created by Gary Herman on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit

class SwarmCell: UITableViewCell {

    static var REUSE_ID: String {
        get {
            return "SWARMCELL";
        }
    }
    
    lazy private var title: UILabel = { //to solve the issue of making too many view specific changes I propose we set subviews as private (forcing the creation of methods to update their properties)
        var label = UILabel();
        label.text = "test";
        return label;
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setupView();
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() { //is this needed? We aren't using Nibs?
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
        self.title.text = swarm.title;
    }
    
    
    func setupView() {
        self.contentView.addSubview(self.title);
        self.setNeedsUpdateConstraints();
    }
    
    
    override func updateConstraints() {
        
        self.title.snp.remakeConstraints({
            make in
            make.edges.equalToSuperview();
        })
        
        super.updateConstraints();
    }
    
}
