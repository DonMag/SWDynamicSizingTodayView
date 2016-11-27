//
//  TodayTableViewCell.swift
//  SampleToday
//
//  Created by Don Mag on 11/25/16.
//  Copyright © 2016 Don Mag. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

	@IBOutlet weak var theLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
