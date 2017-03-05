//
//  SwarmsView.swift
//  WorkoutLogger
//
//  Created by Gary Herman on 12/15/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit
import SnapKit

protocol SwarmViewDelegate {
    func swarmSelected(swarmView: SwarmsView, _ swarm : Swarm, atIndex index: Int);
    func deleteSwarm(swarmView: SwarmsView, _ swarm: Swarm, atIndex index: Int);
}

// display a SwarmDetailView and a table of SwarmTableCells
class SwarmsView: UIView {
    
    var delegate : SwarmViewDelegate?
    weak var viewModel: SwarmViewModelReadDelegate?
    
    
    lazy fileprivate var swarmImage : UIImageView = {
        [unowned self] in //not always necessary, but doesn't hurt and will stop memory issues in a few situations
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 8.0
        iv.layer.masksToBounds = true
        return iv
    }();
    
    lazy fileprivate var swarmsTable : UITableView = {
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
        self.addSubview(self.swarmImage) //use of self ? (I personally like it, makes things clear)
        self.addSubview(self.swarmsTable)
        self.setUpConstraints();
        //self.setNeedsUpdateConstraints();
    }
    
    
    func setUpConstraints() {
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
        
    }
  
    
    override func updateConstraints() { //Constraints should be updated in update Constraints (then you can make use of setNeedsUpdateConstraints)
        
      
        super.updateConstraints();
    }
    
}


// MARK: View Model Hooks

extension SwarmsView {
    
    func hookIntoViewModel(model: SwarmViewModelDataBindDelegate) {
        self.viewModel = model.getSwarmViewModelReadDelegate();
        model.state.addBindee({
            [unowned self] newValue in
            self.viewStateChanged(state: newValue);
            }, runListener: true);
        
    }
    
    
    func viewStateChanged(state: SwarmsViewState) {
        //change the layout to the new state
        switch state {
        case .deleteSwarm(let index, let swarms):
            self.deleteSwarmAt(index, swarms: swarms);
            break;
        case .viewingSwarms(let swarms):
            self.viewingSwarms(swarms);
            break;
        case .editingSwarms:
            break;
        case .loadingSwarms:
            break;
        }
        
    }
    
    // MARK: View State Methods
    
    func viewingSwarms(_ swarms: [Swarm]) {
        self.swarmsTable.reloadData();
    }
    
    
    func deleteSwarmAt(_ index: Int, swarms: [Swarm]) {
        let indexPath = IndexPath(item: index, section: 0);
        self.swarmsTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    
    
}



// MARK: Extensions

extension SwarmsView: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let swarmCell = tableView.dequeueReusableCell(withIdentifier: SwarmCell.REUSE_ID, for: indexPath) as! SwarmCell
        let swarm = self.viewModel!.getSwarms()[indexPath.row];
        swarm.title = "testing";
        swarmCell.populate(with: swarm)
        return swarmCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.getSwarms().count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SwarmCell.height
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let swarm = self.viewModel!.getSwarms()[indexPath.row];
        delegate?.swarmSelected(swarmView: self, swarm, atIndex: indexPath.row);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.delegate?.deleteSwarm(swarmView: self, self.viewModel!.getSwarms()[indexPath.row], atIndex: indexPath.row);
        }
    }
}


