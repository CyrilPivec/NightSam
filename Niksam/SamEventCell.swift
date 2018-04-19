//
//  SamEventCell.swift
//  Niksam
//
//  Created by Cyril PIVEC on 26/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SamEventCell: UITableViewCell {

    @IBOutlet var _image: UIImageView!
    @IBOutlet var _username: UILabel!
    @IBOutlet var _seat: UILabel!
    @IBOutlet var _depart: UILabel!
    @IBOutlet var _radius: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
