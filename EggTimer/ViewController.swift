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
    
    var eggTime = ["Soft": 3, "Medium": 4, "Hard": 6]
    var timePassed: Float = 0
    var totalTime: Float = 0
    var timer = Timer()
    let audioURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    var player: AVAudioPlayer!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        timePassed = 0
        timer.invalidate()
        mainLabel.text = sender.currentTitle!
        mainLabel.textColor = UIColor.systemGray
        totalTime = Float(eggTime[sender.currentTitle!]!)
        // target and selector is like calling method of the object for example A().updateCounter()
        timer = Timer.scheduledTimer(
            timeInterval: 0.001,
            target: self,
            selector: #selector(updateCounter),
            userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if timePassed < totalTime{
            timePassed += 0.001
            //print(timePassed/(totalTime))
            progressBar.progress = timePassed/totalTime
        }
        else {
            progressBar.progress = 1.0
            mainLabel.text = "DONE!"
            mainLabel.textColor = UIColor.systemRed
            timer.invalidate()
            player = try! AVAudioPlayer(contentsOf: audioURL!)
            player.play()
        }
    }
}

//Example class
class A {
    var counter : Int = 6
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
        }
    }
}
