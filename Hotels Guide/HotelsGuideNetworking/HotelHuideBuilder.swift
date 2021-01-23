//
//  HotelHuideBuilder.swift
//  Hotels Guide
//
//  Created by MAC on 23/01/2021.
//

import Foundation

class HotelGuideBuilder{
    static func build(hotels:[Hotel], completion: @escaping (HotelGuide)->Void){
        let remoteFeacher = ImageRemoteStore()
        let localFeacher = ImageLocalStore.shared
        let imageFeacher = CacheBackedDataSource(localStore:localFeacher,remoteStore: remoteFeacher)
        for hotel in hotels {
            var hotelGuide = HotelGuide(hotel: hotel)
            guard let url = hotelGuide.imageUrl else {
                DispatchQueue.main.async {
                    completion(hotelGuide)
                }
                continue
            }
            imageFeacher.find(url) {(result) in
                switch result{
                case .success(let image):hotelGuide.image = image
                case .failure(_):break
                }
                DispatchQueue.main.async {
                    completion(hotelGuide)
                }
            }
        }
    }
}
