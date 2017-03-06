//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Wenn Huang on 2/25/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tweets : [Tweet]!
    //var users : [User]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets : [Tweet])
            in
            self.tweets = tweets
            TwitterClient.sharedInstance.currentAccount(success: { (user : User)
                in
                //self.users = users
                self.tableView.reloadData()
            }) { (error) in
                print(error.localizedDescription)
            }
            
            for tweet in tweets {
                print(tweet.text!)
                print(tweet.favouriteCount)
                print(tweet.retweetCount)
                //print(tweet.followingName ?? 0)
                
               
            }
            self.tableView.reloadData()
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        //self.tableView.reloadData()
    }
    
    @IBAction func onLogOutButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance.logout()
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        if tweets != nil {
            return tweets!.count
        }else{
            return 0
        }
        
        
        
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        //cell.user = users[indexPath.row]
        cell.tweet = tweets[indexPath.row]
        
        
        //print(users[indexPath.row].name)
        
        return cell
        
    }

    
    
    //@IBOutlet weak var toProfileView: UIButton!

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)
        let tweet = tweets![indexPath!.row]
        
        
        let detailViewController = segue.destination as! DetailViewController
        
        detailViewController.tweet = tweet
        
    }
    
    
    

}
