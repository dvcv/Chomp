//
//  Snapshot.swift
//  Choco Chomp
//
//  Created by David Chavez on 3/2/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import UIKit

extension UIImage {
    /// Create an image represenation of the given view
    class func snapshot(from view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return snapshot!
    }
}
