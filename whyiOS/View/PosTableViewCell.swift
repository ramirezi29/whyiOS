//
//  PosTableViewCell.swift
//  whyiOS
//
//  Created by Ivan Ramirez on 9/11/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class PosTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
  
    var post: Post?{
        didSet{
            updateViews()
        }
    }

    func updateViews(){

        nameLabel.text = post?.name
        reasonLabel.text = post?.reason

    }
}
