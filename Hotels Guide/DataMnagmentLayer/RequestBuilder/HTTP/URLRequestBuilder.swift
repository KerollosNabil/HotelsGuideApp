//
//  URLRequestBuilder.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

typealias RequestParams = [String:String]

class URLRequestBuilder {
    
    var baseURLString: String
    var path: String?
    var method: HTTPMethod = .get
    var headers: RequestParams?
    var parameters: RequestParams?
    
    init(with baseURL: String) {
        self.baseURLString = baseURL
    }
    init(with baseURL: String, path: String) {
        self.baseURLString = baseURL
        self.path = path
    }
    
    @discardableResult
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    func set(path: String) -> Self {
        self.path = path
        return self
    }

    @discardableResult
    func set(headers: RequestParams?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func set(parameters: RequestParams?) -> Self {
        self.parameters = parameters
        return self
    }
    
    func build() throws -> URLRequest {
        do {
            
            guard var baseUrl = URL(string: baseURLString) else { throw DataStoreError.missingURL}
            if let path = path{
                baseUrl = baseUrl.appendingPathComponent(path)
            }
            var urlRequest = URLRequest(url:baseUrl,
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 100)
            urlRequest.httpMethod = method.rawValue
            
            
            headers?.forEach {
                urlRequest.addValue($0.value , forHTTPHeaderField: $0.key)
            }

            
            if let params = parameters {
                urlRequest = try URLEncoder.encodeParameters(for: urlRequest, with: params)
            }
            
            return urlRequest
        } catch {
            throw DataStoreError.encodingFailed
        }
    }
    
    
}
