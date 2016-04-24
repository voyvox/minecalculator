//
//  ViewController.swift
//  minecalculator
//
//  Created by Craig Newcomb on 3/31/16.
//  Copyright © 2016 CraigNewcomb. All rights reserved.
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
    
    
    @IBOutlet weak var clearButton: SpringButton!
    
    @IBOutlet weak var divideButton: SpringButton!
    @IBOutlet weak var multiplyButton: SpringButton!
    @IBOutlet weak var addButton: SpringButton!
    @IBOutlet weak var subtractButton: SpringButton!
    @IBOutlet weak var equalButton: SpringButton!
    
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError { print(err.debugDescription) }
    }


    
    
    
    @IBAction func numberPressed(btn: SpringButton!) {
        playSound()
        animate(btn)
        
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    
    
    
    
    
    
    
    

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        animate(divideButton)
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        animate(multiplyButton)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
        animate(subtractButton)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
        animate(addButton)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
       processOperation(currentOperation)
    animate(equalButton)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        animate(clearButton)

        clearOutputLabel()
    }
    
    
    
    
    func animate(btnType: SpringButton!) {
        btnType.animation = "morph"
        btnType.animate()
        
    }
    
    
    
    
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        
        
            
            if currentOperation != Operation.Empty {
                // Run math
                if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double (rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
                    
            }
     
            
            currentOperation = op 
            
        } else {
        
            //this is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        
        }
        
    }
    
    func clearOutputLabel() {
        playSound()
        
        leftValString = ""
        rightValString = ""
        result = ""
        currentOperation = Operation.Empty
        
        runningNumber = ""
        
        outputLbl.text = "0"
        
        //Clear button does nothing currently but play a sound. Rethink how to go about this since your first method causes crashes when clearing, then immediately doing smoething like "+/-/*/divide 3 =" 
    }
        
        
    
 
}
