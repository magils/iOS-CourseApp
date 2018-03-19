//
//  AgreedViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/5/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class AgreedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
    
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
