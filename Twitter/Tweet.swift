//
//  Tweet.swift
//  Twitter
//
//  Created by Wenn Huang on 2/25/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text : String?
    var timestamp : Date?
    var retweetCount : Int = 0
    var favouriteCount : Int = 0
    var followingName : String?
    var userDict : NSDictionary!
    var userImageUrl : URL?
    var dateString : String?

    
    private var dateFormatter : DateFormatter = {
        
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        return dFormatter
        
    }()
    
    init (dictionary : NSDictionary) {
       
        userDict = dictionary["user"] as! NSDictionary
    
        followingName = userDict["name"] as? String
        
        let imageURLString = userDict["profile_image_url_https"] as? String
        
        if imageURLString != nil {
            print("url: \(imageURLString)")
            userImageUrl = URL(string: imageURLString!)!
            
        } else {
            userImageUrl = nil
        }
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int ) ?? 0
        favouriteCount = (dictionary["favourite_count"] as? Int) ?? 0
        
        if let timestampString = dictionary["created_at"] as? String {
            timestamp = dateFormatter.date(from: timestampString)
            
        }
        
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE-MMM-d"
        dateString = dateFormat.string(from: timestamp!)

    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        dictionaries.forEach {
            (dictionary) in tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
