//
//  SmallGameViewController.swift
//  Choco Chomp
//
//  Created by David Chavez on 3/1/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//
import UIKit
import Messages

class SmallGameViewController: UIViewController {
    
    var onSendTap: ((Void) -> Void)?
    let gameActive = "Small"
    var originalGameBoard = GameModel(model: "Small")
    var gameBoard = GameModel(model: "Small")
    let ROWS = GameModel(model: "Small").matrix.count
    let COLS = GameModel(model: "Small").matrix[0].count
    
    @IBOutlet weak var sendLabel: UIButton!
    
    func selection(_ row:Int , col:Int) -> [[Int]]{
        for i in 0...row{
            for j in col...(COLS-1){
                gameBoard.matrix[i][j] = 0
            }
        }
        return gameBoard.matrix
    }
    
    
    
    func prepareURL() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https";
        urlComponents.host = "www.apple.com";
        let playerQuery = URLQueryItem(name: "gameActive",
                                       value: gameActive)
        
        urlComponents.queryItems = [playerQuery]
        for i in 0...ROWS-1{
            for j in 0...COLS-1{
                let queryItem = URLQueryItem(name: "\(originalGameBoard.matrix[i][j])",
                    value: String(gameBoard.matrix[i][j]))
                urlComponents.queryItems?.append(queryItem)
            }
        }
        
        return urlComponents.url!
        
        
    }
    
    

    
    @IBAction func chocolateButton(_ sender: AnyObject) {
        let row = GameModel(model: "Small").selectByTag[Int(sender.tag)]![0]
        let col = GameModel(model: "Small").selectByTag[Int(sender.tag)]![1]
        gameBoard.matrix = selection(row, col: col)
        for i in 0...5{
            for j in 0...2{
                
                if(gameBoard.matrix[i][j] == 0){
                    let button = view.viewWithTag(originalGameBoard.matrix[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }else{
                    let button = view.viewWithTag(originalGameBoard.matrix[i][j]) as! UIButton
                    button.isUserInteractionEnabled = false
                }
            }
        }
        sendLabel.isHidden = false
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        onSendTap?()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

