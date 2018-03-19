//
//  SegmentedViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/10/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstView.isHidden = false
        secondView.isHidden = true
    }
    
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
            secondView.isHidden = true
            
        case 1:
            firstView.isHidden = true
            secondView.isHidden = false
            
        default:
            break
        }
    }
    


}
