//
//  MainLargeGameViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/5/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//
import UIKit

class MainLargeGameViewController: UIViewController {
    
    var originalGameBoard = GameModel(model: "Large")
    var gameBoard = GameModel(model: "Large")
    let ROWS = GameModel(model: "Large").matrix.count
    let COLS = GameModel(model: "Large").matrix[0].count
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var nextPlayer: UILabel!
    
    @IBOutlet weak var nextLabel: UILabel!
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    @IBOutlet weak var loserLabel: UILabel!
    
    
    
    
    var players = [String]()
    
    func selection(_ row:Int , col:Int) -> [[Int]]{
        for i in 0...row{
            for j in col...(COLS-1){
                gameBoard.matrix[i][j] = 0
            }
        }
        return gameBoard.matrix
    }
    
    

    @IBAction func buttonTap(_ sender: AnyObject) {
        print(ROWS)
        print(COLS)
        
    }
    
    
    
    @IBAction func playAgainAction(_ sender: Any) {
        var count = 1
        for i in 0...ROWS-1{
            for j in 0...COLS-1{
                if(gameBoard.matrix[i][j] == 0){
                    gameBoard.matrix[i][j] = count
                    let button = view.viewWithTag(originalGameBoard.matrix[i][j]) as! UIButton
                    button.setImage(UIImage.init(named: "chocolate.png"), for: UIControlState())
                    button.isUserInteractionEnabled = true
                    count += 1
                }
            }
        }
        //set green button back
        let button = view.viewWithTag(originalGameBoard.matrix[ROWS-1][0]) as! UIButton
        button.setImage(UIImage.init(named: "greenChocolate.png"), for: UIControlState())
        
        loserLabel.isHidden = true
        playAgainButton.isHidden = true
        emojiLabel.isHidden = true
        nextPlayer.isHidden = false
        nextLabel.isHidden = false
    }
    
    
    @IBAction func howToPlayButton(_ sender: Any) {
        let alert = UIAlertController(title: "How To Play", message: "Tap on a chocolate square to eat all chocolates above and to the right. Force the other player to eat the green mint chocolate.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ready", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let player1name = UserDefaults.standard.object(forKey: "PlayerOne") as? String{
            nextPlayer.text = player1name
            
            print(players)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
}
