//
//  SwarmsView.swift
//  SwarmApp
//
//  Created by Gary Herman on 12/15/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit
import SnapKit

protocol SwarmViewDelegate {
    func swarmSelected( _ swarm : Swarm )
}

// display a SwarmDetailView and a table of SwarmTableCells
class SwarmsView: UIView {
    
    var delegate : SwarmViewDelegate?
    
    lazy private var swarmImage : UIImageView = {
        [unowned self] in //not always necessary, but doesn't hurt and will stop memory issues in a few situations
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 8.0
        iv.layer.masksToBounds = true
        return iv
    }();
    
    lazy private var swarmsTable : UITableView = {
        [unowned self] in //not always necessary, but doesn't hurt and will stop memory issues in a few situations
        let table = UITableView()
        table.delegate = self
        table.dataSource = self;
        table.register(SwarmCell.self, forCellReuseIdentifier: SwarmCell.REUSE_ID); //adding REUSE_ID to the cell helps stop stupid mistakes
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        swarmImage.image = nil
    }
    
    func setupView() {
        self.addSubview(self.swarmImage) //use of self ?
        self.addSubview(self.swarmsTable)
        self.setNeedsUpdateConstraints();
    }
    
    func reloadData() {
        self.swarmsTable.reloadData();
    }
    
    
    override func updateConstraints() { //Constraints should be updated in update Constraints (then you can make use of setNeedsUpdateConstraints)
        
        swarmImage.snp.remakeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        }
        
        swarmsTable.snp.remakeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(swarmImage.snp.bottom)
        }
        
        super.updateConstraints();
    }
    
}

extension SwarmsView: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let swarmCell = tableView.dequeueReusableCell(withIdentifier: SwarmCell.REUSE_ID, for: indexPath) as! SwarmCell
        //let swarm = SwarmDataManager.shared.sortedswarms[indexPath.row]
        let swarm = Swarm(); //just for my testing
        swarm.title = "testing";
        swarmCell.populate(with: swarm)
        return swarmCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//SwarmDataManager.shared.swarms.count //just for my testing
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SwarmCell.height
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let swarm = SwarmDataManager.shared.sortedswarms[indexPath.row]
        delegate?.swarmSelected( swarm )
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let swarm = SwarmDataManager.shared.sortedswarms[indexPath.row]
            SwarmDataManager.shared.swarms.removeValue(forKey: swarm.id!)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
}


