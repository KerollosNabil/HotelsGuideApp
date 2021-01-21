//
//  HTTPNetworkResponse.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation


import Foundation

struct HTTPNetworkResponse {
    
    // Properly checks and handles the status code of the response
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String,DataStoreError>{
        
        guard let res = response else { return Result.failure(DataStoreError.UnwrappingError)}
        
        switch res.statusCode {
        case 200...299: return Result.success(DataStoreError.success.rawValue)
        case 401: return Result.failure(DataStoreError.authenticationError)
        case 400...499: return Result.failure(DataStoreError.badRequest)
        case 500...599: return Result.failure(DataStoreError.serverSideError)
        default: return Result.failure(DataStoreError.failed)
        }
    }
}
