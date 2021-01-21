//
//  HotelsProvider.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import Foundation

protocol HotelProvider {
  var network: Networking { get }

  func getHotels(_ completion: @escaping (Result<Hotels, DataStoreError>) -> Void)
}
extension HotelProvider {
  func getHotels(_ completion: @escaping (Result<Hotels, DataStoreError>) -> Void) {
    network.execute(EndPoint.hotels, completion: completion)
  }
}
