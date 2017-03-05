//
//  MainGameModel.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/4/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//


import Foundation

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
        }else if(model == "Medium"){
            let matrix = [[1,   2,  3 , 4 , 5],
                          [6,   7,  8,  9, 10],
                          [11,  12, 13, 14, 15],
                          [16,  17, 18, 19, 20],
                          [21,  22, 23, 24, 25],
                          [26,  27, 28, 29, 30],
                          [31,  32, 33, 34, 35],
                          [36,  37, 38, 39, 40]]
            let selectByTag = [1:[0,0],2:[0,1],3:[0,2],4:[0,3],5:[0,4],
                               
                               6:[1,0],7:[1,1],8:[1,2],9:[1,3],10:[1,4],
                               
                               11:[2,0], 12:[2,1],13:[2,2],14:[2,3], 15:[2,4],
                               
                               16:[3,0],17:[3,1],18:[3,2],19:[3,3],20:[3,4],
                               
                               21:[4,0],22:[4,1],23:[4,2],24:[4,3],25:[4,4],
                               
                               26:[5,0],27:[5,1],28:[5,2],29:[5,3],30:[5,4],
                               
                               31:[6,0],32:[6,1], 33:[6,2],34:[6,3],35:[6,4],
                               
                               36:[7,0],37:[7,1],38:[7,2], 39:[7,3],40:[7,4]]
            
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
