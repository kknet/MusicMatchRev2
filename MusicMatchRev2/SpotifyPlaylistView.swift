//
//  SpotifyPlaylistView.swift
//  MusicMatchRev2
//
//  Created by Shukti Shaikh on 4/26/18.
//  Copyright © 2018 Shukti Shaikh. All rights reserved.
//

import UIKit


class SpotifyPlaylistView: UITableViewController {
    
    var spotifyTrackStore = SpotifyTrack.sharedInstance()
    var spotifyAccessToken: String!
    var playlistID: String!
    var searchQueryString: String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.spotifyTrackStore.tracks.removeAll()
        
        SpotifyClient.sharedInstance().getCurrentUserID(accessToken: self.spotifyAccessToken) { (userID, error) in
            if error == nil {
                
                    //Get List of Playlist Tracks
                    SpotifyClient.sharedInstance().getPlaylistTracks(accessToken: self.spotifyAccessToken, userID: userID!, playlistID: self.playlistID, completionHandlerForGetPlaylistTracks: { (result, error) in
                        if error == nil {
                            DispatchQueue.main.async() {
                                self.tableView.reloadData()
                                
                            }
                            
                        } else {
                            print (error)
                        }
                    })
                
            } else {
                print(error)
            }
        }
        
        
    }
   
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return spotifyTrackStore.tracks.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        
        let track = spotifyTrackStore.tracks[indexPath.row]
        let artists = track.artists
        
        var artistString = ""
        for index in 0 ... artists.count - 1 {
            let artist = artists[index] as? [String:AnyObject]
            let name = artist!["name"] as! String
            
            if (index == (artists.count - 1)){
            artistString += "\(name)"
            } else {
                artistString += "\(name), "
            }
        }
         
        
        cell.textLabel?.text = "\(track.name) - \(track.albumName)"
        cell.detailTextLabel?.text = artistString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = spotifyTrackStore.tracks[indexPath.row]
        searchQueryString = track.name
        performSegue(withIdentifier: "searchForVideo", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchForVideo" {
            let destinationViewController = segue.destination as! YouTubeSearchController
            destinationViewController.queryString = self.searchQueryString
            
        }
    }
    
    
}



