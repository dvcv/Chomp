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
    
    var gameActive: String = "Small"
    
    override func willBecomeActive(with conversation: MSConversation) {
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
            if(conversation.selectedMessage == nil){
                childViewController = createMenuViewController()
            }else{
                childViewController = createSmallGameViewController()
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
    
    fileprivate func createSmallGameViewController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SmallGameViewController") as? SmallGameViewController else {
            fatalError("Cannot instantiate view controller")
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
            print(self.gameActive)
        }
        return controller
    }
}

extension MessagesViewController {
    /// Constructs a message and inserts it into the conversation
    func insertMessageWith(caption: String,
                           _ model: GameModel,
                           _ session: MSSession,
                           _ image: UIImage,
                           in conversation: MSConversation) {
        let message = MSMessage(session: session)
        let template = MSMessageTemplateLayout()
        template.image = image
        template.caption = caption
        message.layout = template
        //message.url = model.encode()
        
        // Now we've constructed the message, insert it into the conversation
        conversation.insert(message)
    }
}

