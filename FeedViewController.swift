//
//  FeedViewController.swift
//  iDevSocial
//
//  Created by Cameron Glass on 1/17/17.
//  Copyright © 2017 Cameron Glass. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UITableViewController {
    
    var dataRef = FIRDatabase.database().reference()
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(FeedViewController.loadMessages), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refreshControl!)
        
        loadMessages()
    }

    @IBAction func onSignOut(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let loginScreen = storyboard.instantiateViewController(withIdentifier: "login")
            
            self.present(loginScreen, animated: true, completion: nil)
            print("Logout Successful")
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        
    }
    
    func loadMessages() {
        dataRef.observe(.value, with: { (snapshot) in
            self.posts = []
            if snapshot.hasChild("posts"){
                guard let snapshots = snapshot.childSnapshot(forPath: "posts").children.allObjects as? [FIRDataSnapshot] else{
                    print("No Posts");
                    return
                }
                
                for snap in snapshots {
                    guard let postDictionary = snap.value as? Dictionary<String, AnyObject> else {
                        print("Error getting Post");
                        return;
                    }
                    
                    let post = Post(dictionary: postDictionary)
                    self.posts.insert(post, at: 0)
                }
                
                self.tableView.reloadData();
            }
            self.refreshControl?.endRefreshing()
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        // Configure the cell...
        let post = posts[indexPath.row]
        
        cell.postLabel.text = post.text
        cell.emailLabel.text = post.email

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
