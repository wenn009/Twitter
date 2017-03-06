//
//  tweetCell.swift
//  Twitter
//
//  Created by Wenn Huang on 2/26/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    
    @IBOutlet weak var retweetLabel: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var dateLabel2: UILabel!
    
    @IBOutlet weak var tumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetsDescription: UILabel!
   /* var user: User! {
        didSet{
            nameLabel.text = user.name
            
        }
    }*/
    
    var tweet: Tweet! {
        didSet{
            tweetsDescription.text = tweet.text
            nameLabel.text = tweet.followingName
            if let imageUrl = tweet.userImageUrl{
                tumbImageView.setImageWith(imageUrl)
            }
            dateLabel2.text = tweet.dateString
            
        }
    }
    
    @IBAction func favouriteAction(_ sender: UIButton) {
        
        if tweet.wasFavor == false {
            favouriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"),for: UIControlState.normal)
            TwitterClient.sharedInstance.retweet( success: { (tweet) in
                
            }, failure: { (error: Error) in print(error.localizedDescription) })
            
            tweet.favouriteCount += 1
            tweet.wasFavor = true
        }else {
            tweet.favouriteCount -= 1
                favouriteButton.setImage(#imageLiteral(resourceName: "favor-icon"),for: UIControlState.normal)
            tweet.wasFavor = false
            
        }
    }
    
    @IBAction func retweetAction(_ sender: UIButton) {
        if tweet.wasRetweet == false {

            retweetLabel.setImage(#imageLiteral(resourceName: "retweet-icon-green"),for: UIControlState.normal)
            TwitterClient.sharedInstance.retweet( success: { (tweet) in
                
            }, failure: { (error: Error) in print(error.localizedDescription) })
            
            tweet.retweetCount += 1
            tweet.wasRetweet = true
        }else {
            tweet.retweetCount -= 1
                retweetLabel.setImage(#imageLiteral(resourceName: "retweet-icon"),for: UIControlState.normal)
            tweet.wasRetweet = false
            
        }

    
    }
       
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
