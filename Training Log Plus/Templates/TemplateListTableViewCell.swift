//
//  TemplateListTableViewCell.swift
//  Training Log Plus
//
//  Created by Elliott, Josh on 9/26/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class TemplateListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var templateTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
