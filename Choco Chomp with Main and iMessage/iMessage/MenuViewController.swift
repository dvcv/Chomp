//
//  Menu.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/4/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var onButtonTap: ((Void) -> Void)?
    
    var gameSize: String = "Small"
    
    
    @IBOutlet weak var playGameLabel: UIButton!
    
    @IBAction func startGame(_ sender: AnyObject) {
        onButtonTap?()
        playGameLabel.isHidden = true
        
        //play crunch
    }
    
    override func viewDidLoad() {
    }
    
}
