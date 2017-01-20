//
//  Post.swift
//  iDevSocial
//
//  Created by Cameron Glass on 1/19/17.
//  Copyright © 2017 Cameron Glass. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    var text: String = ""
    var email: String = ""
    
    init(dictionary: Dictionary<String, AnyObject>) {
        guard let text = dictionary["text"] as? String else {
            return
        }
        
        self.text = text;
        
        guard let email = dictionary["email"] as? String else{
            return
        }
        
        self.email = email;
    }

}
