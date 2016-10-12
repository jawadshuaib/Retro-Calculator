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

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        outputLbl.text = ""
        
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
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation (op: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation (op: Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation (op: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation (op: Operation.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
    }
    
    func processOperation (op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math operations
            
            // A user selected an operator, but then selected another operator without
            // first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    // calculate the double values and convert them back to strings
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result

            }
            
            currentOperation = op
            
        } else {
            // This is the first time an operand has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound () {
        if btnSound.isPlaying {
            btnSound.stop()
        } else {
            btnSound.play()
        }
    }
}

