//
//  EventProViewCell.swift
//  Niksam
//
//  Created by Cyril PIVEC on 23/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class EventProViewCell: UITableViewCell {
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _title: UILabel!
    @IBOutlet var _nbParticipant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
