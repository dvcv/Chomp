//
//  InstructionsViewController.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/18/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var slideScrollView: UIScrollView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideScrollView.delegate = self
        let slides:[Slide] = createSlides()
        setUpSlideScrollView(slides: slides)
        pageControll.numberOfPages = slides.count
        pageControll.currentPage = 0
        view.bringSubview(toFront: pageControll)
        
        
    }
    
    func createSlides() -> [Slide]{
        if let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide, let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide, let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide, let slide4: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as? Slide{
            slide1.image.image = UIImage.init(named: "Step 1")
            slide2.image.image = UIImage.init(named: "Step 2")
            slide3.image.image = UIImage.init(named: "Step 3")
            slide4.image.image = UIImage.init(named: "Step 4")
            

            slide1.instruction.text = "To begin a game first player must tap on a chocolate square. Tapping on a chocolate square will break off all other chocolate squares on top and to the right of it."
            slide2.instruction.text = "Second player now takes their turn. If no chocolates are to the right of the ''tapped'' chocolate only the chocolates above will be broken off."
             slide3.instruction.text = "First player now takes their turn. If no chocolates are on top of the ''tapped'' chocolate only the chocolates to the right will be broken off."
            slide4.instruction.text = "Continue alternating players until the poison piece is remaing. Who ever eats the green poison chocolate square loses."
            
            return [slide1,slide2,slide3,slide4]
        }
        
        
        return []
        
    }
    
    func setUpSlideScrollView(slides: [Slide]){
        
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        slideScrollView.contentSize = CGSize(width: view.frame.width*CGFloat(slides.count), height: view.frame.height)
        
        for i in 0..<slides.count{
            slides[i].frame = CGRect(x: view.frame.width*CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControll.currentPage = Int(pageIndex)
    }
    
    
    
    
}
