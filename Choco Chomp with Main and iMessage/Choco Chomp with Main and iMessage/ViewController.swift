//
//  ViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/4/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var noise = Noises()

    @IBAction func playButton(_ sender: Any) {
        noise.playCrunchNoise()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup noise
        noise.setUp()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

