//
//  SwarmsViewController.swift
//  SwarmApp
//
//  Created by Gary Herman on 12/15/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit

class SwarmsViewController: UIViewController {

    var theSwarm : Swarm?
    
    var swarmView: SwarmsView = SwarmsView(); //I like having a reference to the view so that you don't need to cast to the view to access a property/method
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.swarmView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
}

extension SwarmsViewController : SwarmViewDelegate {
    
    func swarmSelected( _ swarm : Swarm ) {
        theSwarm = swarm
    }
    
}
