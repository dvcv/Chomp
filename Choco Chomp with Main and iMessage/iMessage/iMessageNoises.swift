//
//  iMessageNoises.swift
//  Choco Chomp with Main and iMessage
//
//  Created by David Chavez on 3/8/17.
//  Copyright © 2017 David Chavez. All rights reserved.
//


import Foundation
import AVFoundation


class Noises{
    
    
    var crunchNoise = AVAudioPlayer()
    var losingNoise = AVAudioPlayer()
    
    func setUp(){
        do{
            
            crunchNoise = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "crunch", ofType: "wav")!))
        }catch {
            print(error)
        }
        do{
            losingNoise = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "loser", ofType: "wav")!))
        }catch {
            print(error)
        }
    }
    
    func playCrunchNoise(){
        crunchNoise.currentTime = 0
        crunchNoise.play()
    }
    
    func playLosingNoise(){
        crunchNoise.stop()
        losingNoise.currentTime = 0
        losingNoise.play()
    }
    
}
