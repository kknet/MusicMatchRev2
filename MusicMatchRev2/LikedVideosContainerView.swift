//
//  LikedVideosContainerView.swift
//  MusicMatchRev2
//
//  Created by Shukti Shaikh on 6/1/18.
//  Copyright © 2018 Shukti Shaikh. All rights reserved.
//

import Foundation
import UIKit

class LikedVideosContainerView: UIViewController {
    
    fileprivate var LikedVideosView: LikedVideosView!
    fileprivate var YTPlayerViewController: YouTubePlayerViewController!
    var videoID: String!
    var queryString: String!
    
    
    
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        notificationLabel.isHidden = true
        notificationLabel.text = ""
        
        
        guard (childViewControllers.first as? LikedVideosView) != nil else  {
            fatalError("Check storyboard for missing LikedVideosView")
            
        }
        
        
        guard let playerController = childViewControllers.last as? YouTubePlayerViewController else  {
            fatalError("Check storyboard for missing YouTubePlayerViewController")
        }
        
        
        
        YTPlayerViewController = playerController
        
        
        
       // NotificationCenter.default.addObserver(self, selector: #selector(displayMessage), name: Notification.Name("Video Added"), object: nil)
    }
    
    /*
    @objc func displayMessage(_ notification: Notification) {
        let message = notification.userInfo?["message"] as! String
        OperationQueue.main.addOperation {
            
            
            self.notificationLabel.text = message
            self.notificationLabel.isHidden = false
            
            
            
            UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
                
                var labelFrame = self.notificationLabel.frame
                labelFrame.origin.y += (labelFrame.size.height)
                self.notificationLabel.frame = labelFrame
                
            }, completion: { (success) in
                if success == true {
                    self.notificationLabel.isHidden = true
                    var labelFrame = self.notificationLabel.frame
                    labelFrame.origin.y -= (labelFrame.size.height)
                    self.notificationLabel.frame = labelFrame
                }
            })
            
            
            
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    */
    
}