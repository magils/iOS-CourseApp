//
//  TimerViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/8/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timeStepper: UIStepper!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var time = 0
    
    var timer = Timer()
    
    @IBOutlet weak var startTimerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = String(time)
        
        
    }

    
    
    
    @IBAction func changeTime(_ sender: UIStepper) {
        
        time = Int(sender.value)

        updateTimeLabel()
        
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        if time > 0 {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrease), userInfo: nil, repeats: true)
            
            
            startTimerButton.isEnabled = false
            
        
            
        }else {
            
            let alert = UIAlertController.init(title: "Value not valid", message: "The value has to be greater than zero", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    
    @objc func decrease() {
        
        if time > 0  {
              time -= 1
              updateTimeLabel()
        } else {
            timer.invalidate()
            timeStepper.value = 0.0
            startTimerButton.isEnabled = true
        }
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        
        if timer.isValid {
            timer.invalidate()
        }
        
        time = 0
        timeStepper.value = 0
        updateTimeLabel()
        
        startTimerButton.isEnabled = true
        
    }
    
    func updateTimeLabel () {
        timeLabel.text = String(time)
    }
    
}
