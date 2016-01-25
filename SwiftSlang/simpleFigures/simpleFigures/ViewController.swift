//
//  ViewController.swift
//  simpleFigures
//
//  Created by Ness on 12/30/15.
//  Copyright © 2015 Ness. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var solarSystem: SolarSystem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.solarSystem.numberOfNodes = [8,8,30]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

