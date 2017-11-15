//
//  ViewController.swift
//  MusicMatchRev2
//
//  Created by Shukti Shaikh on 10/9/17.
//  Copyright © 2017 Shukti Shaikh. All rights reserved.
//


import UIKit
import MediaPlayer
import GoogleSignIn
import GoogleAPIClientForREST


class MediaPickerViewController: UIViewController, MPMediaPickerControllerDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    private let scopes = [kGTLRAuthScopeYouTubeReadonly, kGTLRAuthScopeYouTube, kGTLRAuthScopeYouTubeForceSsl, kGTLRAuthScopeYouTubeYoutubepartner, kGTLRAuthScopeYouTubeUpload, kGTLRAuthScopeYouTubeYoutubepartnerChannelAudit]
        
        //var accessToken: String!
    private var mediapicker1: MPMediaPickerController!
    
    
    var songTitle: String?
    var songArtist: String?
        

        override func viewDidLoad() {
           
            super.viewDidLoad()
        
            
            
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            
            GIDSignIn.sharedInstance().clientID = "335355113348-3tku90o1ltp2hhvlhf0eehin6kpinb28.apps.googleusercontent.com"
            
            GIDSignIn.sharedInstance().scopes = scopes
            GIDSignIn.sharedInstance().signInSilently()
            
            signInButton.colorScheme = .dark
            signInButton.style = .standard

            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() == true {
            checkMediaAuthorization()

        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
             let accessToken = user.authentication.accessToken!
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.accessToken = accessToken
             checkMediaAuthorization()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    

func checkMediaAuthorization() {
    
    MPMediaLibrary.requestAuthorization { (status) in
        if status == .authorized {
            self.presentMediaPickerController()
            //self.runMediaLibraryQuery()
        } else {
            self.displayMediaLibraryError()
        }
    }
}
    
    
        
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    
    
    func presentMediaPickerController() {
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.allowsPickingMultipleItems = false
        mediaPicker.view.frame =  self.view.frame
        mediaPicker.delegate = self
        mediapicker1 = mediaPicker
        mediapicker1.showsCloudItems = true
    
        
       // self.view.addSubview(mediapicker1.view)
        self.present(mediapicker1, animated: true, completion: nil)
        
        
    }
    
    
    
    func displayMediaLibraryError() {
        var error: String
        switch MPMediaLibrary.authorizationStatus() {
        case .restricted:
            error = "Media library access restricted by corporate or parental settings"
        case .denied:
            error = "Media library access denied by user"
        default:
            error = "Unknown error"
        }
        
        let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        present(controller, animated: true, completion: nil)
    }
    
    
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        songTitle = (mediaItemCollection.items.first?.title)!
        songArtist = (mediaItemCollection.items.first?.artist)!
        
        performSegue(withIdentifier: "searchYouTube", sender: self)
        mediaPicker.dismiss(animated: true, completion: nil)

        
    }
    
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchYouTube" {
            let destinationViewController = segue.destination as! YouTubeSearchController
            destinationViewController.queryString = "\(songTitle!) \(songArtist!)"
            
        }
    }
    
    
    
   
}








