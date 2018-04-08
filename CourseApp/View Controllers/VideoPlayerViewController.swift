//
//  VideoPlayerViewController.swift
//  CourseApp
//
//  Created by Moises Gil on 4/8/18.
//  Copyright © 2018 Moises Gil. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController {

    var playerController = AVPlayerViewController()
    var player: AVPlayer?
    
    var streamVideoPlayerController = AVPlayerViewController()
    var streamPlayer: AVPlayer?
    
    @IBOutlet weak var videoWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //Setting the title of the view controller
        
        navigationItem.title = "Videos on iOS"
        
        //1) Loading local video
        
        let videoLocationString:String? = Bundle.main.path(forResource: "Video", ofType: ".mp4")
        
        if let videoLocation  = videoLocationString  {
            
            
            print("Loading up...")
            
            let videoUrl =  NSURL(fileURLWithPath: videoLocation)
            
            //Loading the local video
            self.player = AVPlayer(url: videoUrl as URL)
            
            //Assigning the player to the player controller
            self.playerController.player = self.player
            
        }
        
        
        //Streaming video
        
        let videoStreamUrlLocation  = NSURL(string: "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_5mb.mp4")
        
        if let videoStreamUrl = videoStreamUrlLocation {
            
            streamPlayer = AVPlayer(url: videoStreamUrl as  URL)
            streamVideoPlayerController.player = streamPlayer
            
        }
        
        
        //Loading Video from Youtube
        let youtubeEmbededVideoCode = "<iframe width=\"\(videoWebView.frame.width)\" height=\"\(videoWebView.frame.height)\" src=\"https://www.youtube.com/embed/7-uNX7sxYtA?rel=0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>"
        
        videoWebView.loadHTMLString(youtubeEmbededVideoCode, baseURL: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func playVideo(_ sender: UIButton) {
        
        //Activate the player and autoplay
        self.present(self.playerController,animated: true,completion: {
            self.playerController.player?.play()
        })
        
    }
    
    
    @IBAction func streamVideo(_ sender: UIButton) {
        
        //Activate player, start the streaming and play the video
        self.present(self.streamVideoPlayerController,animated: true,completion: {
            self.streamVideoPlayerController.player?.play()
        })
        
    }
    
    

}
