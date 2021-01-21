//
//  EndPoints.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

enum HTTPNetworkEndPoint: String{
    case hotels = "hotels"
}
extension HTTPNetworkEndPoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .hotels:
            guard let url = URL(string: "https://mydomain.com/feed") else {
                preconditionFailure("Invalid URL used to create URL instance")
            }

            return URLRequest(url: url)
        }
    }
}
