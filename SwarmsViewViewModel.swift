//
//  SwarmsViewViewModel.swift
//  SwarmApp
//
//  Created by Alex Hartwell on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import Foundation
import Dollar

enum SwarmsViewState {
    case viewingSwarms(swarm: [Swarm]);
    case deleteSwarm(atIndex: Int, newSwarms: [Swarm]);
    case editingSwarms
    case loadingSwarms
}


class SwarmsViewViewModel {
    
    var state: DataBindType<SwarmsViewState> = DataBindType<SwarmsViewState>(value: .loadingSwarms);
    
    private var swarms: [Swarm] = [];
    
    func setSwarms(swarms: [Swarm]) {
        self.swarms = swarms;
        self.state.set(.viewingSwarms(swarm: swarms));
    }
    
    
    
    func removeSwarm(atIndex index: Int) {
        self.swarms.remove(at: index);
        self.state.set(.deleteSwarm(atIndex: index, newSwarms: self.swarms));
    }
    
    
    func changeViewState(_ state: SwarmsViewState) {
        self.state.set(state);
    }
    
}
