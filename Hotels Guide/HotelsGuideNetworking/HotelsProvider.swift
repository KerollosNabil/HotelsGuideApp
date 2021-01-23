//
//  HotelsProvider.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import Foundation

protocol HotelProvider {
    var network: Networking { get set }

  func getHotels(_ completion: @escaping (Result<Hotels, DataStoreError>) -> Void)
}
class HotelFetcher:HotelProvider {
    var network: Networking = NetworkFetcher()
    
    func getHotels(_ completion: @escaping (Result<Hotels, DataStoreError>) -> Void) {
        network.execute(EndPoint.hotels.urlRequest, completion: completion)
    }
}
