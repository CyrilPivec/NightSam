//
//  SamCommentViewCell.swift
//  Niksam
//
//  Created by Cyril PIVEC on 07/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SamCommentViewCell: UITableViewCell {
    
    @IBOutlet var _commentaire: UILabel!
    @IBOutlet var _rate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
