//
//  DetailViewController.swift
//  Twitter
//
//  Created by Wenn Huang on 3/5/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet : Tweet!

    @IBOutlet weak var numofLikeLabel: UILabel!
    @IBOutlet weak var numofretweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLable: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numofLikeLabel.text = String(tweet.favouriteCount)
        
        numofretweetLabel.text = String(tweet.retweetCount)
        
        timeLabel.text = tweet.dateString
        tweetLable.text = tweet.text
        nameLabel.text = tweet.followingName
        thumbImageView.setImageWith(tweet.userImageUrl!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var retweetButton: UIButton!

    @IBAction func retweetAction(_ sender: UIButton) {
        if tweet.wasRetweet == false {
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"),for: UIControlState.normal)
            TwitterClient.sharedInstance.retweet( success: { (tweet) in
                
            }, failure: { (error: Error) in print(error.localizedDescription) })
            
            tweet.retweetCount += 1
            tweet.wasRetweet = true
        }else {
            tweet.retweetCount -= 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"),for: UIControlState.normal)
            tweet.wasRetweet = false
            
        }    }
    @IBOutlet weak var favorButton: UIButton!
    @IBAction func favorAction(_ sender: UIButton) {
        if tweet.wasFavor == false {
            favorButton.setImage(#imageLiteral(resourceName: "favor-icon-red"),for: UIControlState.normal)
            TwitterClient.sharedInstance.retweet( success: { (tweet) in
                
            }, failure: { (error: Error) in print(error.localizedDescription) })
            
            tweet.favouriteCount += 1
            tweet.wasFavor = true
        }else {
            tweet.favouriteCount -= 1
            favorButton.setImage(#imageLiteral(resourceName: "favor-icon"),for: UIControlState.normal)
            tweet.wasFavor = false
            
        }
    }
   
    @IBAction func toProfileView(_ sender: Any) {
       // prepare(for: nil, sender: self)
        
    }
    
    @IBOutlet weak var toProfilePageButton: UIButton!
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toProfilePageButton = sender as! UIButton
        
        //let tweet = tweets![indexPath!.row]
        
        
        let profileViewController = segue.destination as! profileViewController
        
        profileViewController.user = tweet.userDict
    }
    

}
