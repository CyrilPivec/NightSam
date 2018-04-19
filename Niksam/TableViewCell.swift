//
//  TableViewCell.swift
//  Niksam
//
//  Created by Cyril PIVEC on 11/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
