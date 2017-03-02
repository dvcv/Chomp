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
    
    var originalGameBoard = GameModel(model: "Small")
    var gameBoard = GameModel(model: "Small")
    
    
    var gameActive: String = "Small"
    var caption = "Want to play Chomp?"
    var session: MSSession?
    
    
    
    override func willBecomeActive(with conversation: MSConversation) {
        if let messageURL = conversation.selectedMessage?.url {
            self.decodeURL(messageURL)
            caption = "It's your move!"
            session = conversation.selectedMessage?.session
            print(messageURL)
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
            if(gameActive == "Small"){
                childViewController = createSmallGameViewController(with: conversation)
            }else if(gameActive == "Medium"){
                childViewController = createSmallGameViewController(with: conversation)
            }else{
                childViewController = createSmallGameViewController(with: conversation)
            }

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
    
    fileprivate func createSmallGameViewController(with conversation: MSConversation) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SmallGameViewController") as? SmallGameViewController else {
            fatalError("Cannot instantiate view controller")
        }
        print(gameBoard.matrix)
        for i in 0...5{
            for j in 0...2{
                
                if(gameBoard.matrix[i][j] == 0){
                    let button = controller.view.viewWithTag(controller.originalGameBoard.matrix[i][j]) as! UIButton
                    button.setImage(nil, for: UIControlState())
                    button.isUserInteractionEnabled = false
                    
                }
            }
        }
        
        controller.onSendTap = {
            let url = controller.prepareURL()
            let image = UIImage.snapshot(from: controller.view)
            let session = MSSession()
            self.insertMessageWith(caption: self.caption, session, url, image)
            self.dismiss()
        }
        
        return controller
    }
    
    fileprivate func createMenuViewController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
            fatalError("Cannot instantiate view controller")
        }
        controller.onButtonTap = {
            [unowned self] in
            self.requestPresentationStyle(.expanded)
            self.gameActive = controller.gameSize
        }
        return controller
    }
}

extension MessagesViewController {
    /// Constructs a message and inserts it into the conversation
    func insertMessageWith(caption: String,
                           _ session: MSSession,
                           _ url: URL,
                           _ image: UIImage) {
        let message = MSMessage(session: session)
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
            }else if(Int(queryItem.value!) == 0){
                let row = gameBoard.selectByTag[Int(queryItem.name)!]![0]
                let col = gameBoard.selectByTag[Int(queryItem.name)!]![1]
                gameBoard.matrix[row][col] = 0
                
            }
        }
        
        
    }
}

