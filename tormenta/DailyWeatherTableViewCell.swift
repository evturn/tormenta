//
//  DailyWeatherTableViewCell.swift
//  tormenta
//
//  Created by Evan Turner on 2/26/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
