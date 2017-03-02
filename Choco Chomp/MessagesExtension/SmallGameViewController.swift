//
//  SmallGameViewController.swift
//  Choco Chomp
//
//  Created by David Chavez on 3/1/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//
import UIKit

class SmallGameViewController: UIViewController {
    
    var board = GameModel(model: "Small").matrix
    let ROWS = GameModel(model: "Small").matrix.count
    let COLS = GameModel(model: "Small").matrix[0].count
    func selection(_ row:Int , col:Int) -> [[Int]]{
        for i in 0...row{
            for j in col...(COLS-1){
                board[i][j] = 0
            }
        }
        return board
    }
    
    @IBAction func chocolateButton(_ sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

