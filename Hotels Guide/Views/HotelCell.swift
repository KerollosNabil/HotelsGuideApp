//
//  HottelCell.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit

class HotelCell: UICollectionViewCell {
    static let reuseId = "HotelCell"
    
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    func set(hotel:HotelGuide){
        if !hotel.hotelSummary.hotelName.isEmpty{
            hotelName.text = hotel.hotelSummary.hotelName
        }else {
            hotelName.text = "N/A"
        }
        hotelImage.image = hotel.image
    }
    
}

