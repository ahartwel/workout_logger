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
    
    lazy var swarmImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 8.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var swarmsTable : UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(SwarmCell.self, forCellReuseIdentifier: "SwarmCell")
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
        addSubview(swarmImage)
        addSubview(swarmsTable)
        
        layoutView()
    }
    
    func layoutView() {
        swarmImage.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        }
        
        swarmsTable.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(swarmImage.snp.bottom)
        }
    }
}

extension SwarmsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let swarmCell = tableView.dequeueReusableCell(withIdentifier: "SwarmCell", for: indexPath) as! SwarmCell
        let swarm = SwarmDataManager.shared.sortedswarms[indexPath.row]
        swarmCell.populate(with: swarm)
        return swarmCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SwarmDataManager.shared.swarms.count
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


