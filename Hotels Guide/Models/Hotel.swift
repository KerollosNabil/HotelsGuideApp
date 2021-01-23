//
//  Hotel.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import UIKit

struct Hotels:Codable {

    let hotels:[Hotel]
    enum CodingKeys: String, CodingKey {
        case hotels = "hotel"
    }
}

struct Hotel:Codable {

    let hotelId:Int
    let images:[Image]
    let location:HotelLocation
    let hotelSummary:HotelSummary
    
    enum CodingKeys: String, CodingKey {
        case hotelId
        case images = "image"
        case location
        case hotelSummary = "summary"
    }
}
struct Image:Codable {
    let url:String
}
struct HotelLocation:Codable {
    let address:String
    let latitude:Double
    let longitude:Double
}
struct HotelSummary:Codable {
    let highRate:Double
    let lowRate:Double
    let hotelName:String
}
