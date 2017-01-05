//
//  SwarmsViewViewModel.swift
//  SwarmApp
//
//  Created by Alex Hartwell on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import Foundation
import Dollar
import SWRMHelpers


protocol SwarmViewModelReadDelegate: class {
    func getCurrentState() -> SwarmsViewState
    func getSwarms() -> [Swarm];
    func getTheSwarm() -> Swarm?;
}

protocol SwarmViewModelWriteDelegate {
    func setState(state: SwarmsViewState);
    func setSwarms(swarms: [Swarm]);
    func removeSwarm(atIndex index: Int);
    func setTheSwarm(swarm: Swarm);
}

protocol SwarmViewModelDataBindDelegate {
    var state: DataBindType<SwarmsViewState> {get set}
    func getSwarmViewModelReadDelegate() -> SwarmViewModelReadDelegate;
}

protocol SwarmViewModelReadWriteDelegate: SwarmViewModelReadDelegate, SwarmViewModelWriteDelegate {
    func getDataBindDelegate() -> SwarmViewModelDataBindDelegate
}

enum SwarmsViewState {
    case viewingSwarms(swarm: [Swarm]);
    case deleteSwarm(atIndex: Int, newSwarms: [Swarm]);
    case editingSwarms
    case loadingSwarms
}

class SwarmsViewViewModel: SwarmViewModelReadWriteDelegate, SwarmViewModelDataBindDelegate {
    
    internal var state: DataBindType<SwarmsViewState> = DataBindType<SwarmsViewState>(value: .loadingSwarms);
    
    private var swarms: [Swarm] = [];
    private var theSwarm : Swarm?

    
    
    func getSwarmViewModelReadDelegate() -> SwarmViewModelReadDelegate {
        return self;
    }
    
    // MARK: Read and Write Delegate 
    func getDataBindDelegate() -> SwarmViewModelDataBindDelegate {
        return self;
    }
    
    
    // MARK: Read Delegate 
    
    func getCurrentState() -> SwarmsViewState {
        return self.state.get();
    }
    
    func getSwarms() -> [Swarm] {
        return self.swarms;
    }
    
    func getTheSwarm() -> Swarm? {
        return self.theSwarm
    }
    
    // MARK: Write Delegate
    
    func setTheSwarm(swarm: Swarm) {
        self.theSwarm = swarm;
    }
    
    func setState(state: SwarmsViewState) {
        self.state.set(state);
    }
    
    func setSwarms(swarms: [Swarm]) {
        self.swarms = swarms;
        self.state.set(.viewingSwarms(swarm: swarms));
    }
    
    
    func removeSwarm(atIndex index: Int) {
        self.swarms.remove(at: index);
        self.state.set(.deleteSwarm(atIndex: index, newSwarms: self.swarms));
    }
    
    
   
}
