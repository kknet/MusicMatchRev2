//
//  Video+CoreDataProperties.swift
//  
//
//  Created by Shukti Shaikh on 11/10/17.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var playlistItemID: String?
    @NSManaged public var thumbnail: NSData?
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var title: String?
    @NSManaged public var videoID: String?
    @NSManaged public var playlist: Playlist?

}
