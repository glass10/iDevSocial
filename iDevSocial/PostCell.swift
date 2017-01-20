//
//  PostCell.swift
//  iDevSocial
//
//  Created by Cameron Glass on 1/19/17.
//  Copyright © 2017 Cameron Glass. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var postLabel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
