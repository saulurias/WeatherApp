//
//  ForecastTableViewCell.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var dayLabelName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - View Life
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
