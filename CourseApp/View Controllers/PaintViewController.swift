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
    
    var red: CGFloat = 0.0
    var blue : CGFloat = 0.0
    var green: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        drawingContext?.setLineCap(CGLineCap.round)
        
        //Line Width
        drawingContext?.setLineWidth(5)
        
        drawingContext?.setStrokeColor(red: self.red, green: self.green, blue: self.blue, alpha: 1.0)
    
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
            
            red = colors[0]
            green = colors[1]
            blue  = colors[2]
        }
        
        
    }
    
    @IBAction func resetCanvas(_ sender: UIButton) {
        
        canvas.image = nil
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    @IBAction func saveCanvasContent(_ sender: UIButton) {
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
