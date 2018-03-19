//
//  AlertsViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/5/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class AlertsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var ActionSheetButton: UIButton!
    
    @IBAction func showSimpleAlert(_ sender: UIButton) {
        
        
        let simpleAlert = UIAlertController.init(title: "Simple Alert", message: "This is a simple alert, press OK for dismmiss", preferredStyle: .alert)
        
        
        let dismissAction = UIAlertAction.init(title: "OK", style: .default
            , handler: nil)
        
        simpleAlert.addAction(dismissAction)
        
        self.present(simpleAlert, animated: true, completion: nil)
        
    }
    @IBAction func showAlertsWithActions(_ sender: UIButton) {
        
        
        let alertWithActions = UIAlertController.init(title: "Alert with actions", message: "Do you accept the terms of this license?", preferredStyle: .alert)
        
        
        let yesAction = UIAlertAction.init(title: "Yes", style: .default){
            sender in
            
                //Calling a view programmatically from the storyboard
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let agreedViewController = storyboard.instantiateViewController(withIdentifier: "AgreedViewController")
                self.present(agreedViewController, animated: true, completion: nil)
        }
        
        
        let noAction = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
        
        alertWithActions.addAction(yesAction)
        alertWithActions.addAction(noAction)
        
        self.present(alertWithActions, animated: false, completion: nil)
        
        
    }
    
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        
        //Define the style for an actionsheet
        
        let actionSheet = UIAlertController.init(title: "Choose a color", message: "Select a color for the button", preferredStyle: .actionSheet)
        
        
        let blueAction = UIAlertAction.init(title: "Blue", style: .default) { (alertViewController) in
            self.ActionSheetButton.backgroundColor  = UIColor.blue
            self.ActionSheetButton.titleLabel?.textColor = UIColor.white
        }
        
        
        let redAction = UIAlertAction.init(title: "Red", style: .destructive) {
            (alertViewController) in
                self.ActionSheetButton.backgroundColor = UIColor.red
                self.ActionSheetButton.titleLabel?.textColor = UIColor.white
        }
        
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel , handler: nil)
        
        actionSheet.addAction(blueAction)
        actionSheet.addAction(redAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    
    }
    
    
    
}
