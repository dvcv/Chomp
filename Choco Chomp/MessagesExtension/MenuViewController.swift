//
//  MenuViewController.swift
//  Choco Chomp
//
//  Created by David Chavez on 3/1/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var onButtonTap: ((Void) -> Void)?
    
    var gameSize: String = "Small"
    
    @IBAction func gameSizeButtons(_ sender: AnyObject) {
        switch sender.tag {
        case 1:
            gameSize = "Small"
        case 2:
            gameSize = "Medium"
        case 3:
            gameSize = "Large"
        default:
            gameSize = "Small"
        }
        
    }
    
    
    
    @IBAction func startGame(_ sender: AnyObject) {
        onButtonTap?()
    }
}
