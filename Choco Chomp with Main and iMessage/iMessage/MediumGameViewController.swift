//
//  MediumGameViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/4/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//


import UIKit
import Messages

class MediumGameViewController: UIViewController {
    
    var onSendTap: ((Void) -> Void)?
    var onHowToPlayTap: ((Void) -> Void)?
    var onChocolateTap: ((Void) -> Bool)?
    let gameActive = "Medium"
    var originalGameBoard = GameModel(model: "Medium")
    var gameBoard = GameModel(model: "Medium")
    let ROWS = GameModel(model: "Medium").matrix.count
    let COLS = GameModel(model: "Medium").matrix[0].count
    
    @IBOutlet weak var sendLabel: UIButton!
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var howToPlayLabel: UIButton!
    
    
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
        let b = (onChocolateTap?())
        if(sender.tag == 36 && b!){
            let alert = UIAlertController(title: "Ooops!", message: "Force the other player to eat the green mint chocolate. Choose a different chocolate.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ready", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let row = GameModel(model: "Medium").selectByTag[Int(sender.tag)]![0]
            let col = GameModel(model: "Medium").selectByTag[Int(sender.tag)]![1]
            gameBoard.matrix = selection(row, col: col)
            for i in 0...ROWS-1{
                for j in 0...COLS-1{
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
            if(sender.tag == 36){
                emojiLabel.isHidden = false
            }
        }
    }
    
    
    @IBAction func sendButton(_ sender: AnyObject) {
        onSendTap?()
        
    }
    
    
    @IBAction func howToPlay(_ sender: Any) {
        onHowToPlayTap?()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
