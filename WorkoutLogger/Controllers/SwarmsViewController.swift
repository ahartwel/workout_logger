//
//  SwarmsViewController.swift
//  WorkoutLogger
//
//  Created by Gary Herman on 12/15/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit

class SwarmsViewController: UIViewController {

    
    
    var viewModel: SwarmViewModelReadWriteDelegate = SwarmsViewViewModel();
    var swarmView: SwarmsView = SwarmsView(); //I like having a reference to the view so that you don't need to cast to the view to access a property/method
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.swarmView;
        
        
        let dataBindDelegate = self.viewModel.getDataBindDelegate();
        self.swarmView.hookIntoViewModel(model: dataBindDelegate); //have the view hook into values from the View Model
        self.loadData();
    }
    
    func loadData() {
        self.viewModel.setState(state: .loadingSwarms);
        SwarmDataManager.shared.getSwarms(callback: {
            swarms in
            self.viewModel.setSwarms(swarms: swarms);
        });

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
}

extension SwarmsViewController : SwarmViewDelegate {
    
    func deleteSwarm(swarmView: SwarmsView, _ swarm: Swarm, atIndex index: Int) {
        self.viewModel.removeSwarm(atIndex: index);
    }


    func swarmSelected(swarmView: SwarmsView, _ swarm : Swarm, atIndex index: Int) {
        self.viewModel.setTheSwarm(swarm: swarm);
    }
}
