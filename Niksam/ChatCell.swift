//
//  ChatCell.swift
//  Niksam
//
//  Created by nawin on 10/21/17.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class ChatCell: BaseCell {
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblMessageDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
