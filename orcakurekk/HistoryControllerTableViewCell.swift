//
//  HistoryControllerTableViewCell.swift
//  orcakurekk
//
//  Created by Asel Şeşen on 23.08.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class HistoryControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var reservationTime: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reservationImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reservationDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
