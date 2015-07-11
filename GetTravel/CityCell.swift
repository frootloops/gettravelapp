//
//  CityCell.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    var city: City! {
        didSet {
            cityName.text = city.name
            countryName.text = city.country
            cover.image = city.cover
        }
    }
}
