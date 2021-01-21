//
//  Networking.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

protocol Networking {
  func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, DataStoreError>) -> Void)
}

extension Networking {
    func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, DataStoreError>) -> Void) {
        let urlRequest = requestProvider.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if error != nil {
                    completion(.failure(DataStoreError.UnwrappingError))
                    return
                }

                guard let data = data else {
                    completion(.failure(DataStoreError.noData))
                    return
                }
                let responseResult = HTTPNetworkResponse.handleNetworkResponse(for: response as? HTTPURLResponse)
                
                if case .failure(let error) = responseResult{
                    completion(.failure(error))
                    return
                }
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(.success(decodedObject))
            } catch {
                completion(.failure(DataStoreError.decodingFailed))
            }
        }.resume()
    }
}
