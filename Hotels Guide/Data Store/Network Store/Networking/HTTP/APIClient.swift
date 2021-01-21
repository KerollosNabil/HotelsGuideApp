//
//  APIClient.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

class APIClient {

  // Rest of code
  
  func buildURLRequest<T: APIRequest>(for request: T) throws -> URLRequest {
    return try URLRequestBuilder(with: request.baseURL, path: request.path)
        .set(method: request.method)
        .set(headers: request.headers)
        .set(parameters: request.parameters)
        .build()
  }
}
