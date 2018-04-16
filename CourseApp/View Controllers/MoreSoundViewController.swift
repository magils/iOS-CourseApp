//
//  MoreSoundViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 4/15/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class MoreSoundViewController: UIViewController {
    
    
    var musicPlayer = AVAudioPlayer()
    var audioSession = AVAudioSession()
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupAudioPlayer()
        
    }
    
    
    
    func setupAudioPlayer() {
        
        let musicUrl = Bundle.main.url(forResource: "Music", withExtension: "mp3")
        
        if let musicLocation = musicUrl  {
            
            do {
                
                musicPlayer = try AVAudioPlayer(contentsOf: musicLocation)
                musicPlayer.prepareToPlay()
                
            }catch {
                print(error)
            }
            
            
            
        }
    }
    
    
    func setupAudioSession() {
        
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            //Set the category for background playback
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
            
        }catch let sessionError {
            print(sessionError)
        }
    }
    
    @IBAction func playSystemSound(_ sender: UIButton) {
        
        
        let soundUrl = Bundle.main.url(forResource: "sample-sound", withExtension: "aif")
        
        
        if let soundLocation = soundUrl  {
            
            var soundId: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundLocation as CFURL, &soundId)
            
            AudioServicesPlaySystemSoundWithCompletion(soundId) {
                AudioServicesDisposeSystemSoundID(soundId)
            }
            
        }
        
        
        
    }
    
    
    @IBAction func playSound(_ sender: UIButton) {
        
        if !musicPlayer.isPlaying {
            
            setupAudioSession()
            
            musicPlayer.play()
            
            playButton.setTitle("Pause", for: .normal)
            
        } else {
            musicPlayer.pause()
            do {
            
                try audioSession.setActive(false, with: .notifyOthersOnDeactivation)
                
            }catch let audioSessionError {
                print(audioSessionError)
            }
            playButton.setTitle("Play", for: .normal)
            
        }
        
    }
    
    
    @IBAction func restartSound(_ sender: UIButton) {
    
        if musicPlayer.isPlaying {
            
            musicPlayer.stop()
            musicPlayer.currentTime = 0
            
            
            do{
                
                try audioSession.setActive(false, with: .notifyOthersOnDeactivation)
                
            }catch let audioSessionError {
                print(audioSessionError)
            }
            
            
            playButton.setTitle("Play", for: .normal)
            
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
    
}
