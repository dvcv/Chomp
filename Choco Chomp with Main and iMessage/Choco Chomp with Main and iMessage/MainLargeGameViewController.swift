//
//  MainLargeGameViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/5/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//
import UIKit
import GoogleMobileAds

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
    
    
    @IBOutlet weak var foilBackground: UIImageView!
    
    //Banner View
    @IBOutlet weak var bannerView: GADBannerView!
    
    //Noise
    var noise = Noises()
    
    
    var players = [String]()
    
    func selection(_ row:Int , col:Int) -> [[Int]]{
        for i in 0...row{
            for j in col...(COLS-1){
                gameBoard.matrix[i][j] = 0
            }
        }
        return gameBoard.matrix
    }
    
    

    @IBAction func chocolateButton(_ sender: AnyObject) {
        
        let b = (gameBoard.matrix[ROWS-2][0] != 0 || gameBoard.matrix[ROWS-1][1] != 0)
        
        if(sender.tag == 71 && b){
            let alert = UIAlertController(title: "Ooops!", message: "Force the other player to eat the green poison chocolate. Choose a different chocolate.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ready", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            //Crunch
            noise.playCrunchNoise()
            
            let row = GameModel(model: "Large").selectByTag[Int(sender.tag)]![0]
            let col = GameModel(model: "Large").selectByTag[Int(sender.tag)]![1]
            gameBoard.matrix = selection(row, col: col)
            for i in 0...ROWS-1{
                for j in 0...COLS-1{
                    if(gameBoard.matrix[i][j] == 0){
                        let button = view.viewWithTag(originalGameBoard.matrix[i][j]) as! UIButton
                        button.setImage(nil, for: UIControlState())
                        button.isUserInteractionEnabled = false
                    }
                }
            }
            
            if(sender.tag == 71){
                //Losing Noise
                noise.playLosingNoise()
                
                emojiLabel.isHidden = false
                foilBackground.isHidden = true
                playAgainButton.isHidden = false
                loserLabel.isHidden = false
                nextPlayer.isHidden = true
                nextLabel.isHidden = true
                loserLabel.text = "\(nextPlayer.text == players[0] ? players[0] : players[1]) ate the poison!"
            }
            //change next player
            nextPlayer.text = nextPlayer.text == players[0] ? players[1] : players[0]
            nextLabel.text = nextPlayer.text == players[0] ? "Player 1:" : "Player 2:"
        }
        
        
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
        foilBackground.isHidden = false
        nextPlayer.isHidden = false
        nextLabel.isHidden = false
        nextPlayer.text = players[0]
        nextLabel.text = "Player 1:"

    }
    
    
    @IBAction func howToPlayButton(_ sender: Any) {
        let alert = UIAlertController(title: "How To Play", message: "Tap on a chocolate square to eat all chocolates above and to the right of it. Force the other player to eat the green poison chocolate.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Noise setup
        noise.setUp()
        
        //Banner View
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bannerView.adUnitID = "ca-app-pub-2467079541328028/5716947197"
        bannerView.rootViewController = self
        bannerView.load(request)
        

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
