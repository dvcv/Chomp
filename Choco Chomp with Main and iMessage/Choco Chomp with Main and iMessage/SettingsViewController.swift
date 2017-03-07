//
//  SettingsViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/4/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    
    @IBOutlet weak var playerOneInput: UITextField!
    
    
    @IBOutlet weak var playerTwoInput: UITextField!
    
    @IBOutlet weak var chooseGameBoardLabel: UILabel!
    
    @IBOutlet weak var smallGameButton: UIButton!
    
    @IBOutlet weak var mediumGameButton: UIButton!
    
    
    @IBOutlet weak var largeGameButton: UIButton!
    
    var boardSize: Int = 0

    
    @IBAction func playerOneInputAction(_ sender: AnyObject) {
        
        UserDefaults.standard.set(playerOneInput.text, forKey: "PlayerOne")
        checkIfNamesArePresent()
        self.view.endEditing(true)
    }
    
    @IBAction func playerTwoInputAction(_ sender: AnyObject) {
        UserDefaults.standard.set(playerTwoInput.text, forKey: "PlayerTwo")
        checkIfNamesArePresent()
        self.view.endEditing(true);
    }
    
    func checkIfNamesArePresent() -> Void{
        if(playerOneInput.text == "" || playerTwoInput.text == ""){
            chooseGameBoardLabel.isHidden = true
            smallGameButton.isHidden = true
            mediumGameButton.isHidden = true
            largeGameButton.isHidden = true
        }else if(playerOneInput.text != "" && playerTwoInput.text != ""){
            chooseGameBoardLabel.isHidden = false
            smallGameButton.isHidden = false
            mediumGameButton.isHidden = false
            largeGameButton.isHidden = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let player1name = UserDefaults.standard.object(forKey: "PlayerOne") as? String{
            playerOneInput.text = player1name
        }
        if let player1name = UserDefaults.standard.object(forKey: "PlayerTwo") as? String{
            playerTwoInput.text = player1name
        }
        if(playerOneInput.text == "" || playerTwoInput.text == ""){
            chooseGameBoardLabel.isHidden = true
            smallGameButton.isHidden = true
            mediumGameButton.isHidden = true
            largeGameButton.isHidden = true
        }
    }
    
    
    @IBAction func sizeSelect(_ sender: AnyObject) {
        
        self.boardSize = sender.tag
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch boardSize {
        case 1:
            let DestViewController: MainSmallGameViewController = segue.destination as! MainSmallGameViewController
            DestViewController.players.append(playerOneInput.text!)
            DestViewController.players.append(playerTwoInput.text!)
        case 2:
            let DestViewController: MainMediumGameViewController = segue.destination as! MainMediumGameViewController
            DestViewController.players.append(playerOneInput.text!)
            DestViewController.players.append(playerTwoInput.text!)
        case 3:
            let DestViewController: MainLargeGameViewController = segue.destination as! MainLargeGameViewController
            DestViewController.players.append(playerOneInput.text!)
            DestViewController.players.append(playerTwoInput.text!)
        default: break
            
        }
    }
    
    
}
