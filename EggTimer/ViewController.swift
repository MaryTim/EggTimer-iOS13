//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        progressBar.progress = 0
        secondsPassed = 0
        labelText.text = "How do you like your egg?"
        
        let hardness = sender.currentTitle
        let totalTime = eggTime[hardness!]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            
            if self.secondsPassed <= totalTime {
                
                self.secondsPassed += 1
                
                let percentageProgress = Float(self.secondsPassed) / Float(totalTime)
                
                self.progressBar.progress = percentageProgress
                
                if percentageProgress == 1.0 {
                    self.labelText.text = "Done ✅"
                    
                    self.timer.invalidate()
                    
                    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                    self.player = try! AVAudioPlayer(contentsOf: url!)
                    self.player.play()
                }
            }
        }
    }
    
}
