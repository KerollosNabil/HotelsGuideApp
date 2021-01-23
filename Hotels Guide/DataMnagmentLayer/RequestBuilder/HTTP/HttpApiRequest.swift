//
//  HttpApiRequest.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

typealias RequestParams = [String: Any]

protocol APIRequest {
    associatedtype Resource: Decodable
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams? { get }
    var headers: [String: Any]? { get }
}
