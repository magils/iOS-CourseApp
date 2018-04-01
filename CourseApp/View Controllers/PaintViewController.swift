//
//  PaintViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/18/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    
    var swiped = false
    
    var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var opacity: CGFloat = 1.0
    var brushSize: CGFloat = 5.0
    var lineCap: CGLineCap = CGLineCap.round
    var lineCapColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    var backgroundColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = backgroundColor

        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first {
            
            lastPoint = touch.location(in: self.view)
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        if let touch = touches.first {
            
            let currentLocation = touch.location(in: view)
            drawLine(lastPoint, currentLocation)
            
            lastPoint = currentLocation
            
        }
    }
    
    
    /*
        This allow to paint touches, this means the user touch the screen but do not swipe the finger in the screen
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if !swiped  {
            drawLine(lastPoint, lastPoint)
        }
    }
    
    
    func drawLine(_ fromPoint: CGPoint, _ toPoint: CGPoint) {
        
        //Create a Bitmap context of the size of the image view
        
        //TODO: Find the size of the Navigation Item and substract to the full view
        let viewRealSize = view.frame.size
        
        UIGraphicsBeginImageContext(viewRealSize)
        
        let drawingContext = UIGraphicsGetCurrentContext()
        
        
        //Set the boundary of the drawing
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        
        //Define the properties of the paint
        
        //Define the begging point
        drawingContext?.move(to: fromPoint)
        
        //Define the destination point
        drawingContext?.addLine(to: toPoint)
        
        //Define the form of the drawing
        drawingContext?.setLineCap(lineCap)
        
        //Line Width
        drawingContext?.setLineWidth(brushSize)
        
        drawingContext?.setStrokeColor(red: lineCapColor.cgColor.components![0], green: lineCapColor.cgColor.components![1], blue: lineCapColor.cgColor.components![2], alpha: opacity)
    
        //Define the style of the line to draw
        drawingContext?.setBlendMode(CGBlendMode.normal)
        
        //Create the stoke with the properties defined
        drawingContext?.strokePath()
        
        
        //Asign the stroke defined to UIImage of the image view
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        
        //End the context
        UIGraphicsEndImageContext()
        
        
    }
    
    
    @IBAction func chooseColor(_ sender: UIButton) {
        
        if let colors = sender.backgroundColor?.cgColor.components {
        
            lineCapColor = UIColor(red: colors[0], green: colors[1], blue: colors[2], alpha: opacity)
        }
        
        
    }
    
    @IBAction func resetCanvas(_ sender: UIButton) {
        
        canvas.image = nil
        lineCapColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        canvas.backgroundColor = backgroundColor
        
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    @IBAction func saveCanvasContent(_ sender: UIButton) {
        
        UIGraphicsBeginImageContext(canvas.bounds.size)
        canvas.image?.draw(in: CGRect(x: 0, y: 0, width: canvas.frame.width, height: canvas.frame.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let activityView = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        
        self.present(activityView, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Navigation

    
    // Set the current values of colors for the Settings View
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let settingsViewController = segue.destination as! SettingsViewController
        
        //Settings the current values of the PaintViewController to the SettingsViewController before open it
        settingsViewController.paintViewControllerDelegate = self
        
        //Setting the colors
        settingsViewController.redLineValueColor = lineCapColor.cgColor.components![0]   * 255
        settingsViewController.greenLineValueColor = lineCapColor.cgColor.components![1] * 255
        settingsViewController.blueLineValueColor = lineCapColor.cgColor.components![2]  * 255
        
        settingsViewController.redBackgroundValueColor = backgroundColor.cgColor.components![0] * 255
        settingsViewController.greenBackgroundValueColor = backgroundColor.cgColor.components![1] * 255
        settingsViewController.blueBackgroundValueColor = backgroundColor.cgColor.components![2] * 255

        //Setting the Line Cap and Brush Size
        settingsViewController.lineCap = self.lineCap
        settingsViewController.brushSize = self.brushSize
        settingsViewController.opacity = self.opacity
        
    }


}


extension PaintViewController : SettingsViewControllerDelegate{
    
    //This will set the values of the setting view when the user finish
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {

        
        if settingsViewController.isBackgroundColor {
             backgroundColor = settingsViewController.backgroundColor
        }else {
            lineCapColor = settingsViewController.lineCapColor
        }

        self.opacity = settingsViewController.opacity
        self.brushSize = settingsViewController.brushSize
        self.lineCap = settingsViewController.lineCap
        
        
        self.canvas.backgroundColor = settingsViewController.backgroundColor
        self.lineCapColor = settingsViewController.lineCapColor
        
        
    }
    
}
