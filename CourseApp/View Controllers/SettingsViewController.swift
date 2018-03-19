//
//  SettingsViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/18/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var brushSizeLabel: UILabel!
    
    var brushSize: CGFloat = 0.0
    var opacity : CGFloat = 0.0
    var redValueColor : CGFloat = 0.0
    var blueValueColor: CGFloat = 0.0
    var greenValueColor: CGFloat = 0.0
    
    @IBOutlet weak var opacityLabel: UILabel!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    
    @IBOutlet weak var previewCanvas: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       navigationItem.title = "Settings"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func brushSlider(_ sender: UISlider) {
        
        brushSizeLabel.text = "Brush Size: \(String(format:"%.2f",sender.value))"
        brushSize = CGFloat(sender.value)
       
        updatePreviewCanvas()
    }
    
    @IBAction func setOpacity(_ sender: UISlider) {
        
        opacity = CGFloat(sender.value)
        opacityLabel.text = "Opacity:\(String(format:"%.2f",opacity.native))"
        
        updatePreviewCanvas()
    }
    
    
    @IBAction func setRedValue(_ sender: UISlider) {
        redValueColor = CGFloat(sender.value)
        redValueLabel.text = String(format: "%.2f",redValueColor.native)
        
        updatePreviewCanvas()
    }
  
    @IBAction func setBlueValue(_ sender: UISlider) {
        blueValueColor = CGFloat(sender.value)
        blueValueLabel.text = String(format: "%.2f",blueValueColor.native)
        
        updatePreviewCanvas()
        
    }
    
    @IBAction func setGreenValue(_ sender: UISlider) {
        greenValueColor = CGFloat(sender.value)
        greenValueLabel.text = String(format: "%.2f", greenValueColor.native)
        
         updatePreviewCanvas()
    }
    
    
    
    
    //TODO: Create the final definition for this method
    func updatePreviewCanvas() {
        
        self.view.backgroundColor =  UIColor(red: redValueColor / 255, green: greenValueColor / 255, blue: blueValueColor / 255 , alpha: opacity)
        
        
    }
    
    
    @IBAction func chooseLineCap(_ sender: UIButton) {
        
        
        let lineCapActionSheet = UIAlertController.init(title: "Line caps", message: "Select the type of line cap for drawing in the canvas", preferredStyle: .actionSheet)
        
        
        let roundLineCapAction = UIAlertAction.init(title: "Round", style: .default) { (alertAction) in
            print("TODO")
        }
        
        
        let squareLineCapAction = UIAlertAction.init(title: "Square", style: .default) { (alertAction) in
            print("TODO")
        }
        
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel
            , handler: nil)
        
        
        lineCapActionSheet.addAction(roundLineCapAction)
        lineCapActionSheet.addAction(squareLineCapAction)
        lineCapActionSheet.addAction(cancelAction)
        
        self.present(lineCapActionSheet, animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
