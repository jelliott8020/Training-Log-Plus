//
//  AmrapPerformance_TVCell.swift
//  Training Log Plus
//
//  Created by Josh Elliott on 10/19/19.
//  Copyright © 2019 JoshElliott. All rights reserved.
//

import UIKit

class AmrapPerformance_TVCell: UITableViewCell {

    @IBOutlet weak var dateAndWeightLabel: UILabel!
    
    @IBOutlet weak var repsAndTMLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
