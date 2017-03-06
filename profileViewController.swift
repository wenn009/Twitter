//
//  profileViewController.swift
//  Twitter
//
//  Created by Wenn Huang on 3/5/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var numberofFollower: UILabel!
    @IBOutlet weak var NumberofFollowingLabel: UILabel!
    @IBOutlet weak var numberOfTweetsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    var user : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let followers = user["followers_count"] as! Int
        numberofFollower.text = String(followers)
        print(user["followers_count"] ?? 0)
        let following = user["friends_count"] as! Int
        NumberofFollowingLabel.text = String (following)
        print(user["following"] ?? 0)
        let listed_count = user["listed_count"] as! Int
        numberOfTweetsLabel.text = String(listed_count)
        print(user["listed_count"] ?? 0)
        nameLabel.text = user["name"] as? String
        let imageURLString = user["profile_image_url_https"] as? String
        var userImageUrl : URL!
        if imageURLString != nil {
            print("url: \(imageURLString)")
            userImageUrl = URL(string: imageURLString!)!
            
        } else {
            userImageUrl = nil
        }

    thumbImageView.setImageWith(userImageUrl)
       
        let profileURLString = user["profile_background_image_url_https"] as? String
        var userProfileImageUrl : URL!
        if profileURLString != nil {
            print("url: \(imageURLString)")
            userProfileImageUrl = URL(string: imageURLString!)!
            
        } else {
            userImageUrl = nil
        }
      
        profileImageView.setImageWith(userProfileImageUrl)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
