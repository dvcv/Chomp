//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by David Chavez on 3/1/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    var originalGameBoard = GameModel(model: "Medium")
    var gameBoard = GameModel(model: "Medium")
    var gameActive: String = "Medium"
    var caption = "Want to play Chomp?"
    var session: MSSession?
    
    fileprivate func isSenderSameAsRecipient(_ conversation: MSConversation) -> Bool{
        if(conversation.selectedMessage?.senderParticipantIdentifier == nil){
            return false
        }else{
            return conversation.localParticipantIdentifier == conversation.selectedMessage?.senderParticipantIdentifier
        }
    }

    
    override func willBecomeActive(with conversation: MSConversation) {
        if let messageURL = conversation.selectedMessage?.url {
            self.decodeURL(messageURL)
            let player = "$\(conversation.localParticipantIdentifier)"
            caption = player + " chomped the chocolate!"
            self.session = conversation.selectedMessage?.session
        }
        
        configureChildViewController(for: presentationStyle, with: conversation)

    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        
        guard let conversation = self.activeConversation else { return }
        configureChildViewController(for: presentationStyle, with: conversation)
        
    }
}

extension MessagesViewController {
    fileprivate func configureChildViewController(for presentationStyle: MSMessagesAppPresentationStyle,
                                                  with conversation: MSConversation) {
        // Remove any existing child view controllers
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Now let's create our new one
        let childViewController: UIViewController
        
        switch presentationStyle {
        case .compact:
            childViewController = createMenuViewController()
        case .expanded:
                childViewController = createMediumGameViewController(with: conversation)
        }
       
        // Add controller
        addChildViewController(childViewController)
        childViewController.view.frame = view.bounds
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        
        childViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        childViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        childViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        childViewController.didMove(toParentViewController: self)
    }
   
    //Medium
    fileprivate func createMediumGameViewController(with conversation: MSConversation) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MediumGameViewController") as? MediumGameViewController else {
            fatalError("Cannot instantiate view controller")
        }
        
        
        
        //Checks to see if the sender is the same as the receiver.
        //If true alert pops out
        if(isSenderSameAsRecipient(conversation)){
            var message = "Please wait for the other player to chomp the chocolate."
            //Losing Position
            if(gameBoard.matrix[controller.ROWS-1][0] == 0){
                message = "Game Over"
            }
            
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
        }
        
        //checks to see if there are still moves available
        controller.onChocolateTap = {
            let b = (self.gameBoard.matrix[controller.ROWS-2][0] != 0 || self.gameBoard.matrix[controller.ROWS-1][1] != 0)
            
            return b
        }
        
        
        
        //displays current game board
        for i in 0...controller.ROWS - 1{
            for j in 0...controller.COLS - 1{
                
                if(gameBoard.matrix[i][j] == 0){
                    controller.gameBoard.matrix[i][j] = 0
                    let button = controller.view.viewWithTag(controller.originalGameBoard.matrix[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }
            }
            //Losing Position
            if(gameBoard.matrix[controller.ROWS-1][0] == 0){
                let message = "Game Over"
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
        //On button tap, an alert pops out showing the player how to play.
        controller.onHowToPlayTap = {
            let alert = UIAlertController(title: "How To Play", message: "Tap on a chocolate square to eat all chocolates above and to the right. Force the other player to eat the green mint chocolate.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ready", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        //When player is ready to send move this is called
        controller.onSendTap = {
            controller.sendLabel.isHidden = true
            controller.howToPlayLabel.isHidden = true
            let url = controller.prepareURL()
            let image = UIImage.snapshot(from: controller.view)
            
            var session = self.session
            if session == nil {
                self.session = MSSession()
                session = self.session
            }
            //Checks for Losing Position
            if(controller.gameBoard.matrix[controller.ROWS-1][0] == 0){
                let player = "$\(conversation.localParticipantIdentifier)"
                self.caption = player + " ate the poison!"
            }
            self.insertMessageWith(caption: self.caption, session: session, url, image)
            self.dismiss()
        }
        
        return controller
    }
    //Menu
    fileprivate func createMenuViewController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
            fatalError("Cannot instantiate view controller")
        }
        controller.onButtonTap = {
            [unowned self] in
            self.requestPresentationStyle(.expanded)
            
        }
        return controller
    }
}

extension MessagesViewController {
    /// Constructs a message and inserts it into the conversation
    func insertMessageWith(caption: String,
                           session: MSSession?,
                           _ url: URL,
                           _ image: UIImage) {
        
        let message = MSMessage(session: session!)
        let template = MSMessageTemplateLayout()
        template.image = image
        template.caption = caption
        message.layout = template
        message.url = url
        let conversation = self.activeConversation

        // Now we've constructed the message, insert it into the conversation
        conversation?.insert(message)
    }
}

extension MessagesViewController {
    
    func decodeURL(_ url: URL) {
        let components = URLComponents(url: url,
                                       resolvingAgainstBaseURL: false)
        
        for queryItem in (components?.queryItems)! {
            
            if queryItem.name == "gameActive" {
                
                gameActive = queryItem.value!
                self.gameActive = queryItem.value!
            }else if(Int(queryItem.value!) == 0){
                let row = gameBoard.selectByTag[Int(queryItem.name)!]![0]
                let col = gameBoard.selectByTag[Int(queryItem.name)!]![1]
                gameBoard.matrix[row][col] = 0
                
            }
        }
        
        
    }
}


