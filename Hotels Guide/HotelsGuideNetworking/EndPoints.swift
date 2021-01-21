//
//  EndPoints.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

enum EndPoint: String{
    case hotels = "hotels"
}
extension EndPoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .hotels:
             return try! URLRequestBuilder(with: Constants.baseURL, path: self.rawValue).build()
        }
    }
}
