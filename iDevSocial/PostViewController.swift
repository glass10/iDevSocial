//
//  PostViewController.swift
//  iDevSocial
//
//  Created by Cameron Glass on 1/19/17.
//  Copyright © 2017 Cameron Glass. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    @IBOutlet weak var postField: UITextView!
    
    var dataRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        postField.becomeFirstResponder();
        
        postField.text = "Type your thoughts here..."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing (textView: UITextView) {
        if (postField.isFirstResponder) {
            postField.text = nil
        }
    }
    
    func textViewDidEndEditing (textView: UITextView) {
        if postField.text.isEmpty || postField.text == "" {
            postField.text = "Type your thoughts here..."
        }
    }
    
    @IBAction func onPost(_ sender: Any) {
        print("Posting...");
        let usersRef = dataRef.child("posts").childByAutoId()
        
        var postInfo: [String: String] = [:]
        postInfo["text"] = postField.text
        postInfo["user"] = FIRAuth.auth()?.currentUser?.email!
        
        usersRef.setValue(postInfo)
        self.navigationController?.popViewController(animated: true)
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
