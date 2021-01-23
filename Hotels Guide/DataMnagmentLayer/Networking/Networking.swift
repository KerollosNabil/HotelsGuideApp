//
//  Networking.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import UIKit

protocol Networking {
    func execute<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, DataStoreError>) -> Void)
    func image(_ request: URLRequest, completion: @escaping (Result<UIImage, DataStoreError>) -> Void)
}

class NetworkFetcher: Networking {
    func image(_ request: URLRequest, completion: @escaping (Result<UIImage, DataStoreError>) -> Void) {
        let urlRequest = request

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
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
            
            if let image = UIImage(data: data){

                completion(.success(image))
            }else{
                completion(.failure(DataStoreError.decodingFailed))
            }
            
        }.resume()
    }
    
    
    func execute<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, DataStoreError>) -> Void) {
        let urlRequest = request

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
