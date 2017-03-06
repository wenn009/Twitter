//
//  TwitterClient.swift
//  Twitter
//
//  Created by Wenn Huang on 2/25/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey:  "DB6UruibEzQ6Wy1MOeznEO8Cm", consumerSecret:  "s4DSP6nGE3xCKlOjFNuCMYXMyQN4aHAuEJB7cXykq0FHVgTbGG")!
    
    var loginSuccess : (()->())?
    var loginFailure : ((Error) -> ())?
    
    func login(success : @escaping () -> (), failure: @escaping (Error) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token",method: "GET",callbackURL: URL(string: "Twitter-client://oauth"),scope: nil, success: { (requestToken) in
            //print("I got a token")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            
            UIApplication.shared.open(url)
        }, failure: { (error) in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: User.userDidlogoutNotificationName, object: nil)
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token",
                         method: "POST",
                         requestToken: requestToken,
                         success: { (accessToken) in
                            self.currentAccount(success: { (user) in
                                User.currentUser = user
                                self.loginSuccess?()
                            }, failure: { (error) in
                                self.loginFailure?(error)
                            })
                            self.loginSuccess?()
        }) { (error) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    
    func homeTimeline(success: @escaping (([Tweet]) -> ()), failure : @escaping
        (Error) -> ()) {
        get("1.1/statuses/home_timeline.json",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries:
                    dictionaries)
                success(tweets)
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func retweet(success: @escaping (([Tweet]) -> ()), failure : @escaping
        (Error) -> ()) {
        get("1.1/statuses/retweet/243149503589400576.json",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries:
                    dictionaries)
                success(tweets)
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
    func favor(success: @escaping (([Tweet]) -> ()), failure : @escaping
        (Error) -> ()) {
        get("1.1/favorites/create.json?id=243138128959913986",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries:
                    dictionaries)
                success(tweets)
        }, failure: { (task, error) in
            failure(error)
        })
    }
        
    func currentAccount(success: @escaping ((User) -> ()), failure : @escaping
        (Error) -> ()) {
        get("1.1/account/verify_credentials.json",
            parameters: nil,
            progress: nil,
            success: { (task, response) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                print("screeenname: \(user.screenName)")
                print("name: \(user.name)")
                print("profile url: \(user.profileURL)")
                print("description: \(user.tagLine)")
                success(user)
        }, failure: { (task, error) in
            failure(error)
        })
    }
    
   }
