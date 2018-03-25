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
    
    var redLineValueColor : CGFloat = 0.0
    var blueLineValueColor: CGFloat = 0.0
    var greenLineValueColor: CGFloat = 0.0

    var redBackgroundValueColor : CGFloat = 0.0
    var blueBackgroundValueColor: CGFloat = 0.0
    var greenBackgroundValueColor: CGFloat = 0.0
    
    var lineCap: CGLineCap = CGLineCap.round
    var backgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var lineCapColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var isBackgroundColor = false
    
    @IBOutlet weak var colorFillerSegmentControl: UISegmentedControl!
    
    var paintViewControllerDelegate: SettingsViewControllerDelegate?
    
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var previewCanvas: UIImageView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var brushSizeSlider: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Settings"
        
        updateSlidersWith(red: redLineValueColor, green: greenLineValueColor, blue: blueLineValueColor)
        
        self.opacitySlider.value = Float(opacity)
        self.opacityLabel.text = String(format: "Opacity: %.2f",self.opacitySlider.value)
        
        self.brushSizeSlider.value = Float(brushSize)
        self.brushSizeLabel.text = String(format: "Brush Size: %d", Int(self.brushSizeSlider.value))
        
        lineCapColor = UIColor(red: redLineValueColor, green: greenLineValueColor, blue: blueLineValueColor, alpha: opacity)
        backgroundColor = UIColor(red: redBackgroundValueColor, green: greenBackgroundValueColor, blue: blueBackgroundValueColor, alpha: 1.0)
        
        
        updatePreviewCanvas()

        
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
        
        redValueLabel.text = String(format: "%d",Int(sender.value))
        
        if isBackgroundColor {
            redBackgroundValueColor = CGFloat(sender.value)
        }else {
            redLineValueColor = CGFloat(sender.value)
        }
        
        updatePreviewCanvas()
        
    }
  
    
    @IBAction func setGreenValue(_ sender: UISlider) {

        greenValueLabel.text = String(format: "%d", Int(sender.value))
        
        if isBackgroundColor {
            greenBackgroundValueColor = CGFloat(sender.value)
        }else{
            greenLineValueColor = CGFloat(sender.value)
        }

        updatePreviewCanvas()
    }
    
    
    @IBAction func setBlueValue(_ sender: UISlider) {
        
        blueValueLabel.text = String(format: "%d", Int(sender.value))
        
        if isBackgroundColor {
             blueBackgroundValueColor = CGFloat(sender.value)
        }else {
            blueLineValueColor = CGFloat(sender.value)
        }

        updatePreviewCanvas()
        
    }
    
    //TODO: Create the final definition for this method
    func updatePreviewCanvas() {
        
        UIGraphicsBeginImageContext(previewCanvas.frame.size)

        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(lineCap)
        context?.setLineWidth(brushSize)
        context?.move(to: CGPoint(x: 80, y: 53))
        context?.addLine(to: CGPoint(x: 80, y: 53))
        
        if isBackgroundColor  {
            backgroundColor = UIColor(red: redBackgroundValueColor / 255, green: greenBackgroundValueColor / 255, blue: blueBackgroundValueColor / 255 , alpha: opacity)
        } else {
            lineCapColor = UIColor(red: redLineValueColor / 255, green: greenLineValueColor / 255, blue: blueLineValueColor / 255 , alpha: opacity)
        }
        
        context?.setStrokeColor(red: lineCapColor.cgColor.components![0], green: lineCapColor.cgColor.components![1], blue: lineCapColor.cgColor.components![2], alpha: opacity)
        context?.strokePath()

        previewCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        previewCanvas.backgroundColor = backgroundColor
        
    }
    
    
    @IBAction func chooseColorToFill(_ sender: UISegmentedControl) {
        
        
        switch colorFillerSegmentControl.selectedSegmentIndex {
            
        case 0:
            opacitySlider.isEnabled = true
            isBackgroundColor = false
            
            //Set the values of the color sliders with the values of the line cap
            updateSlidersWith(red: redLineValueColor, green: greenLineValueColor, blue: blueLineValueColor)

        case 1:
            opacitySlider.isEnabled = false
            opacitySlider.setValue(1.0, animated: true)
            opacity = CGFloat(1.0)
            opacityLabel.text = String(format: "Opacity: %.2f",opacitySlider.value) as String
            isBackgroundColor = true
            
            //Set the values of the color sliders with the values of background
            updateSlidersWith(red: redBackgroundValueColor, green: greenBackgroundValueColor, blue: blueBackgroundValueColor)

        default:
            break
            
        }
    }
    
    
    
    @IBAction func chooseLineCap(_ sender: UIButton) {
        
        
        let lineCapActionSheet = UIAlertController.init(title: "Line caps", message: "Select the type of line cap for drawing in the canvas", preferredStyle: .actionSheet)
        
        
        let roundLineCapAction = UIAlertAction.init(title: "Round", style: .default) { (alertAction) in
            self.lineCap = CGLineCap.round
        }
        
        
        let squareLineCapAction = UIAlertAction.init(title: "Square", style: .default) { (alertAction) in
            self.lineCap = CGLineCap.square
        }
        
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel
            , handler: nil)
        
        
        lineCapActionSheet.addAction(roundLineCapAction)
        lineCapActionSheet.addAction(squareLineCapAction)
        lineCapActionSheet.addAction(cancelAction)
        
        self.present(lineCapActionSheet, animated: true, completion: nil)
    }
    
    
    func updateSlidersWith(red: CGFloat, green: CGFloat, blue: CGFloat){
        
        redSlider.setValue(Float(red * 255), animated: true)
        greenSlider.setValue(Float(green * 255), animated: true)
        blueSlider.setValue(Float(blue * 255), animated: true)
        
        self.redValueLabel.text = String(format: "%d", Int(redSlider.value)) as String
        self.greenValueLabel.text = String(format: "%d",Int(greenSlider.value)) as String
        self.blueValueLabel.text = String(format: "%d", Int(blueSlider.value)) as String
        
        updatePreviewCanvas()
        
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        //Going Back to the Caller View Controller
        self.paintViewControllerDelegate?.settingsViewControllerFinished(self)
        
    }


}

protocol SettingsViewControllerDelegate: class  {

    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController)
    
}
