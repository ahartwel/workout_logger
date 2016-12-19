//
//  ViewController.swift
//  SwarmApp
//
//  Created by SWARM on 11/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit

func print(_ item: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(item(), separator:separator, terminator: terminator)
    #endif
}

class ViewController: UINavigationController {

    let transitionManager = NavigationControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

