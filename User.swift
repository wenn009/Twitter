//
//  User.swift
//  Twitter
//
//  Created by Wenn Huang on 2/25/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name : String?
    var screenName: String?
    var profileURL: URL?
    var tagLine: String?
    var dictionary : NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary 
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        if let profileURLString = dictionary["profile_image_url_https"] as? String {
            profileURL = URL(string: profileURLString)
        }
        
        tagLine = dictionary["description"] as? String
        
    }
    
    static let userDidlogoutNotificationName = NSNotification.Name(rawValue: "UserDidLogout")
    
    static var _currentUser : User?
    
    class var currentUser : User? {
        set {
            let user = newValue
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if user != nil {
                let data = try! JSONSerialization.data(withJSONObject: (user?.dictionary)!, options: [])
                defaults.setValue(data, forKey: "currentUser")
            } else {
                defaults.removeObject(forKey: "currentData")
            }
            defaults.synchronize()
            
        }
        
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                if let userData = defaults.object(forKey: "currentUser") as? Data {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                    
                }
            }
            return _currentUser
        }
    }

}
