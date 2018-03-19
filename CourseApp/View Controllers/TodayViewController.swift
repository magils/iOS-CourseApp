//
//  TodayViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/9/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let dateFormatter =  DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
        
        updateScreenValues()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScreenValues), userInfo: nil, repeats: true)

    }
    
    
   @objc func updateScreenValues() {
        let dateString = dateFormatter.string(from: Date())
        let timeString = timeFormatter.string(from: Date())
    
        timeLabel.text = timeString
        dateLabel.text = dateString
    
    }
    
    @IBAction func changeDateFormat(_ sender: UIButton) {
        
        let dateFormatActionSheet = UIAlertController.init(title: "Date Formats", message: "Choose a date format", preferredStyle: .actionSheet)
        
        let shortFormatAction = UIAlertAction.init(title: "Short", style: .default) { (alertAction) in
                self.dateFormatter.dateStyle = .short
        }
        
        
        let mediumFormatAction = UIAlertAction.init(title: "Medium", style: .default) { (alertAction) in
                self.dateFormatter.dateStyle = .medium
        }
        
        let longFormatAction = UIAlertAction.init(title: "Long", style: .default) { (alertAction) in
            
                self.dateFormatter.dateStyle = .long
            
            
        }
        
        
        let fullFormatAction = UIAlertAction.init(title: "Full", style: .default) { (alertAction) in
            
                self.dateFormatter.dateStyle = .full
            
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        dateFormatActionSheet.addAction(shortFormatAction)
        dateFormatActionSheet.addAction(mediumFormatAction)
        dateFormatActionSheet.addAction(longFormatAction)
        dateFormatActionSheet.addAction(fullFormatAction)
        dateFormatActionSheet.addAction(cancelAction)
        
        self.present(dateFormatActionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func changeTimeFormat(_ sender: UIButton) {
        
        let timeActionSheetFormat = UIAlertController.init(title: "Time Formats", message: "Select a time format", preferredStyle: .actionSheet)
        
        let shortFormatAction = UIAlertAction.init(title: "Short", style: .default) { (alertAction) in
                self.timeFormatter.timeStyle = .short
        }
        
        let mediumFormatAction = UIAlertAction.init(title: "Medium", style: .default) { (alertAction) in
               self.timeFormatter.timeStyle = .medium
        }
        
        let longFormatAction  = UIAlertAction.init(title: "Long", style: .default) { (alertAction) in
                self.timeFormatter.timeStyle = .long
        }
        
        let fullFormatAction = UIAlertAction.init(title: "Full", style: .default) { (alertAction) in
                self.timeFormatter.timeStyle = .full
        }
        
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        //Adding the actions
        
        timeActionSheetFormat.addAction(shortFormatAction)
        timeActionSheetFormat.addAction(mediumFormatAction)
        timeActionSheetFormat.addAction(longFormatAction)
        timeActionSheetFormat.addAction(fullFormatAction)
        
        timeActionSheetFormat.addAction(cancelAction)
        
        self.present(timeActionSheetFormat, animated: true, completion: nil)
        
        
    }
    
    
    

}
