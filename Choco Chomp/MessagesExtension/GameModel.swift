//
//  GameModel.swift
//  Choco Chomp
//
//  Created by David Chavez on 3/1/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import Foundation
import Messages

// This deletes the top and to the right points from original selection
struct GameModel{
   var matrix:[[Int]]
    
   var selectByTag:[Int:[Int]]
    
    
}
extension GameModel{
    
    
    init(model: String) {
        if(model == "Small"){
            let matrix = [[1,   2,  3],
                          [4,   5,  6],
                          [7,   8,  9],
                          [10,  11, 12],
                          [13,  14, 15],
                          [16,  17, 18]]
            let selectByTag = [1:[0,0],2:[0,1],3:[0,2],
                               4:[1,0],5:[1,1],6:[1,2],
                               7:[2,0],8:[2,1],9:[2,2],
                               10:[3,0],11:[3,1],12:[3,2],
                               13:[4,0],14:[4,1],15:[4,2],
                               16:[5,0],17:[5,1],18:[5,2]]
        self.init(matrix: matrix, selectByTag: selectByTag)
        }else{
            let matrix = [[1,   2,  3],
                          [4,   5,  6],
                          [7,   8,  9],
                          [10,  11, 12],
                          [13,  14, 15],
                          [16,  17, 18]]
            let selectByTag = [1:[0,0],2:[0,1],3:[0,2],
                               4:[1,0],5:[1,1],6:[1,2],
                               7:[2,0],8:[2,1],9:[2,2],
                               10:[3,0],11:[3,1],12:[3,2],
                               13:[4,0],14:[4,1],15:[4,2],
                               16:[5,0],17:[5,1],18:[5,2]]
            self.init(matrix: matrix, selectByTag: selectByTag)
        }
    }
}

