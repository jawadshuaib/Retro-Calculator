//
//  ViewController.swift
//  retro-calculator
//
//  Created by Jawad Shuaib on 2016-10-11.
//  Copyright © 2016 Jawad Shuaib. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path (forResource: "btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer (contentsOf: soundUrl as URL)
            btnSound.prepareToPlay() // get the sound ready
        } catch let err as NSError {
            print (err.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed (btn: UIButton!) {
            btnSound.play()
    }

}

