//
//  URLEncoder.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation


struct URLEncoder {
    
    /// Encode and set the parameters of a url request
    static func encodeParameters(for urlRequest: URLRequest, with parameters: RequestParams) throws  -> URLRequest{
        guard let url = urlRequest.url else{ throw DataStoreError.missingURL }
        
        var urlRequest = urlRequest

        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        return urlRequest
    }
    
    
}
