//
//  ViewController.swift
//  HIIT-Timer
//
//  Created by Nilang Patel on 2020-05-25.
//  Copyright © 2020 Nilang Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var secondsA = 30
    var restseconds = 10
   
    var loop = 0
    var countdown = Timer()
    var restTimer = Timer()
    
    //slider mechanism for active timer
    @IBOutlet weak var activelabel: UILabel!
    @IBOutlet weak var activeSliderO: UISlider!
    @IBAction func activeSliderA(_ sender: UISlider) {
        secondsA = Int(sender.value)
        activelabel.text = String(secondsA)
        
    }
    
    //slider mechanism for rest timer
    @IBOutlet weak var restlabel: UILabel!
    @IBOutlet weak var restSliderO: UISlider!
    @IBAction func restSliderA(_ sender: UISlider) {
        restseconds = Int(sender.value)
        restlabel.text = String(restseconds)
    }
    
    //stepper mechanism for looping timer
    @IBOutlet weak var looplabel: UILabel!
    @IBOutlet weak var loopStepperO: UIStepper!
    @IBAction func loopStepperA(_ sender: UIStepper) {
        loop = Int(sender.value)
        looplabel.text = String(loop)
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func startAction(_ sender: UIButton) {
        
// try putting the while loop here
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
        startOutlet.isHidden = true
        pauseOutlet.isHidden = false
        activeSliderO.isHidden = true
        restSliderO.isHidden = true
        // new addition
        
    }
    @objc func count(){
        secondsA -= 1
        activelabel.text = "Active: " + String(secondsA)
        if (secondsA == 0){
            countdown.invalidate()
            
    // once countdown invalidates, rest timer begins
            restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.rest), userInfo: nil, repeats: true)
        }
    }
    //rest timer function
    @objc func rest(){
        restseconds -= 1
        restlabel.text = "Rest: " + String(restseconds)
        if (restseconds == 0){
            restTimer.invalidate()
          
            looper()
            
            
            
        }
    }
     // once countdown and rest invalidate, then loop -= 1 and the start action runs again, this will loop as long as loop > 0
    func looper(){
    if (secondsA == 0) && (restseconds == 0){
        
        secondsA = Int(activeSliderO.value)
        activeSliderO.setValue(Float(secondsA), animated: true)
            activelabel.text = String(secondsA)
                
            restseconds = Int(restSliderO.value)
            restSliderO.setValue(Float(restseconds), animated: true)
            restlabel.text = String(restseconds)
            
            loop -= 1
            looplabel.text = String(loop)

            countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)

// this will end the circuit
        if (loop == 0){
          activeSliderO.isHidden = false
            startOutlet.isHidden = false
            restSliderO.isHidden = false
            pauseOutlet.isHidden = true
                
            countdown.invalidate()
            restTimer.invalidate()
        }
        
        }
    }
        
    // pause action for timer
    
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBAction func pauseAction(_ sender: UIButton) {
        countdown.invalidate()
        startOutlet.isHidden = false
        pauseOutlet.isHidden = true
    
    }
    // how everything resets when you press the stop button
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stopAction(_ sender: UIButton) {
        activeSliderO.isHidden = false
        startOutlet.isHidden = false
        restSliderO.isHidden = false
        pauseOutlet.isHidden = true
        
        countdown.invalidate()
        restTimer.invalidate()
        
        secondsA = 30
        activeSliderO.setValue(30, animated: true)
        activelabel.text = "30"
        
        restseconds = 10
        restSliderO.setValue(10, animated: true)
        restlabel.text = "10"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    // start and stop button customization
        startOutlet.buttondesign()
        stopOutlet.buttondesign()
        pauseOutlet.buttondesign()
        
    // manual override to make the stop button color red, and pause button yellow/orange
        stopOutlet.backgroundColor = UIColor.systemRed
        pauseOutlet.backgroundColor = UIColor.systemOrange
    }
}
extension UIButton{
// the button dimensions are that of a square (56 x 56) and the corner radius makes it a circle
    func buttondesign(){
        self.backgroundColor = UIColor.systemGreen
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 4)
    }
    
}



