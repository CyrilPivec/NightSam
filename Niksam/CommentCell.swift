//
//  CommentCell.swift
//  Niksam
//
//  Created by Cyril PIVEC on 03/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet var _comment: UILabel!
    @IBOutlet var _note: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
