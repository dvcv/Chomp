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
    
    
    
    override func willBecomeActive(with conversation: MSConversation) {
        if let messageURL = conversation.selectedMessage?.url {
            self.decodeURL(messageURL)
            let player = "$\(conversation.localParticipantIdentifier)"
            let player2 = "$\(activeConversation?.selectedMessage?.senderParticipantIdentifier)"
            print(player + " " + player2)
            caption = player + " chomped the chocolate, it's your move!"
            session = conversation.selectedMessage?.session
            if(self.isSenderSameAsRecipient()){
                print("Same")
            }
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
        
        
        if(isSenderSameAsRecipient()){
            for i in 0...controller.ROWS - 1{
                for j in 0...controller.COLS - 1{
                    let button = controller.view.viewWithTag(controller.originalGameBoard.matrix[i][j]) as! UIButton
                    button.isUserInteractionEnabled = false
                    
                }
            }
        }
        
        for i in 0...controller.ROWS - 1{
            for j in 0...controller.COLS - 1{
                
                if(gameBoard.matrix[i][j] == 0){
                    controller.gameBoard.matrix[i][j] = 0
                    let button = controller.view.viewWithTag(controller.originalGameBoard.matrix[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }
            }
        }
        
        controller.onSendTap = {
            controller.sendLabel.isHidden = true
            let url = controller.prepareURL()
            let image = UIImage.snapshot(from: controller.view)
            self.insertMessageWith(caption: self.caption, session: self.session, url, image)
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
        var session = session
        if session == nil {
            self.session = MSSession()
            session = self.session
        }
        
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

extension MessagesViewController {
    fileprivate func isSenderSameAsRecipient() -> Bool{

        guard let conversation = activeConversation else { return false }
        guard let message = conversation.selectedMessage else { return false }
        return message.senderParticipantIdentifier == conversation.localParticipantIdentifier
    }
}

