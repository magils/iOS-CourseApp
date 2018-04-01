//
//  SoundViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 3/25/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let musicFile = Bundle.main.path(forResource: "Music", ofType: ".mp3")

        
        do {
            try  player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!) )
        }catch {
            print(error)
        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func playMusic(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func pauseMusic(_ sender: UIButton) {
        player.stop()
    }
    
    @IBAction func stopMusic(_ sender: UIButton) {
        player.stop()
        player.currentTime = 0
    }
    
    
    @IBAction func restartMusic(_ sender: UIButton) {
        player.currentTime = 0
    }
    
}
