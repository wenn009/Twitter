//
//  tweetCell.swift
//  Twitter
//
//  Created by Wenn Huang on 2/26/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    
    
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
    
    
       
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
