//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Lin Myat on 16/07/2021.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound : AVAudioPlayer?
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = " -"
//        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: url)
            btnSound?.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: Any){
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onAddPressed(sender: Any){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: Any){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: Any){
        processOperation(operation: Operation.Multiply)
    }

    @IBAction func onEqualPressed(sender: Any){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: Any){
        playSound()
                runningNumber.removeAll()
                outputLbl.text = "0"
                currentOperation = Operation.Empty
        
    }
    
    
    func playSound() {
        if btnSound?.isPlaying == true {
            btnSound?.stop()
        }
        btnSound?.play()
    }
        
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            // user selected other operation key without entering number
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\((Double(leftValStr))! * (Double(rightValStr))!)"
                }else if currentOperation == Operation.Divide{
                    result = "\((Double(leftValStr))! / (Double(rightValStr))!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Empty{
                    result = "\(Double(leftValStr)! * 0)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            currentOperation = operation
        }else {
            // first time operator had been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}
    
    

