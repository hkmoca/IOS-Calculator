//
//  ViewController.swift
//  retro-calculator
//
//  Created by Héctor Moreno on 08/07/16.
//  Copyright © 2016 Hkapp. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtrac = "-"
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
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
        try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
        print(err.debugDescription)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func numberPressed(btn: UIButton!) {
    
    playSound()
    runningNumber += "\(btn.tag)"
    outputLbl.text = runningNumber
    
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
      processOperation(Operation.Divide)
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onSubtracPressed(sender: AnyObject) {
        processOperation(Operation.Subtrac)
        
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
        
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
        
    }
    
    func processOperation(op: Operation) {
            playSound()
        
        
        if currentOperation != Operation.Empty {
            
            if currentOperation != Operation.Empty{
                
            
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation  == Operation.Multiply {
               result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            
            } else if currentOperation == Operation.Divide {
               result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                
            } else if currentOperation == Operation.Subtrac {
               result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
               result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            
            }
            currentOperation = op
            
            
        } else {
               leftValStr = runningNumber
                runningNumber = ""
                currentOperation = op
            
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

