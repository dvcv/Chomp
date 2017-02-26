//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by David Chavez on 2/21/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    let info = Info()
    var originalGameBoard = Game()
    var gameBoard = Game()
    let ROWS = Info().matrix.count
    let COLS = Info().matrix[0].count
    
    
    var currentPlayer: String = "1"
    var caption = "Want to play Chomp?"
    var session: MSSession?
    
    
    @IBOutlet weak var test: UILabel!
    
    
    func prepareURL() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https";
        urlComponents.host = "www.apple.com";
        let playerQuery = URLQueryItem(name: "currentPlayer",
                                       value: currentPlayer)
        
        urlComponents.queryItems = [playerQuery]
        for i in 0...ROWS-1{
            for j in 0...COLS-1{
                let queryItem = URLQueryItem(name: "\(originalGameBoard.board[i][j])",
                    value: String(gameBoard.board[i][j]))
                    urlComponents.queryItems?.append(queryItem)
            }
        }
        
        return urlComponents.url!
       
        
    }
    
    func decodeURL(_ url: URL) {
        
        let components = URLComponents(url: url,
                                       resolvingAgainstBaseURL: false)
        
        for queryItem in (components?.queryItems)! {
            
            if queryItem.name == "currentPlayer" {
                
                currentPlayer = queryItem.value == "1" ? "2" : "1"
            }else if(Int(queryItem.value!) == 0){
                let row = info.selectByTag[Int(queryItem.name)!]![0]
                let col = info.selectByTag[Int(queryItem.name)!]![1]
                gameBoard.board[row][col] = 0
                            
            }
        }
                
        
    }
    
    
    func prepareMessage(_ url: URL) {
        
        if session == nil {
            session = MSSession()
        }
        
        let message = MSMessage(session: session!)
        
        let layout = MSMessageTemplateLayout()
        layout.caption = caption
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,
                                               view.isOpaque, 0);
        self.view.drawHierarchy(in: view.bounds,
                                    afterScreenUpdates: true)
        
        layout.image = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();

        
        message.layout = layout
        message.url = url
        
        let conversation = self.activeConversation
        
        conversation?.insert(message, completionHandler: {(error) in
            if let error = error {
                print(error)
            }
        })
        
        self.dismiss()
    }
    
    func gameStatus() -> Bool{
        
    
        return true
    }
    

    

    @IBAction func button(_ sender: AnyObject) {
        
        if(currentPlayer == "1"){
        
        let row = info.selectByTag[Int(sender.tag)]![0]
        let col = info.selectByTag[Int(sender.tag)]![1]
        gameBoard.board = gameBoard.selection(row, col: col)
    
        for i in 0...5{
            for j in 0...2{
                
                if(gameBoard.board[i][j] == 0){
                    let button = view.viewWithTag(originalGameBoard.board[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }
            }
        }
        
        let url = prepareURL()
        prepareMessage(url)
            
        }
        
    }
 
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        
        if let messageURL = conversation.selectedMessage?.url {
            decodeURL(messageURL)
            caption = "It's your move!"
            session = conversation.selectedMessage?.session
            
        }
        
        for i in 0...5{
            for j in 0...2{
                
                if(gameBoard.board[i][j] == 0){
                    let button = view.viewWithTag(originalGameBoard.board[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }
            }
        }
        print(currentPlayer)
        
        
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
  
    

}
