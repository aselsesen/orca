//
//  ViewControllerTableViewCell.swift
//  orcakurekk
//
//  Created by Asel Şeşen on 13.08.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var reservationDateForCell: UILabel!
    
    @IBOutlet weak var reservationTimeForCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
