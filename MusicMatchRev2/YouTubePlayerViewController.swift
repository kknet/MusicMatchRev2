//
//  YouTubePlayerViewController.swift
//  MusicMatchRev2
//
//  Created by Shukti Shaikh on 10/18/17.
//  Copyright © 2017 Shukti Shaikh. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper


class YouTubePlayerViewController: UIViewController{
    
    
    @IBOutlet weak var playerView: YTPlayerView!
    
   
    var videoID: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadVideo), name: Notification.Name("Cell Selected"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadVideoFromPlaylist), name: Notification.Name("Playlist Item Selected"), object: nil)
    }
    

    @objc func loadVideo(_ notification: Notification) {
        videoID = notification.userInfo?["videoID"] as! String
        
        let playerVars: [AnyHashable: Any] = ["playsinline" : 1 ]
        self.playerView.load(withVideoId: self.videoID, playerVars: playerVars)
    }
    
    @objc func loadVideoFromPlaylist(_ notification: Notification) {
        videoID = notification.userInfo?["videoID"] as! String
        
        let playerVars: [AnyHashable: Any] = ["playsinline" : 1 ]
      self.playerView.load(withVideoId: self.videoID, playerVars: playerVars)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
}
