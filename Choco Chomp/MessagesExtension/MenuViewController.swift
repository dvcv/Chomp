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
    
    @IBAction func startGame(_ sender: AnyObject) {
        onButtonTap?()
    }
}
