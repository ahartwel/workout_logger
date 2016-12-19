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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = SwarmsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SwarmsViewController : SwarmViewDelegate {
    func swarmSelected( _ swarm : Swarm ) {
        theSwarm = swarm
    }
}
