//
//  ImageRemoteStore.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit

struct ImageRemoteStore:RemoteStore {
    
    func find(_ objectID: String, completion: @escaping (Result<UIImage, DataStoreError>) -> Void) {
        let networking = NetworkFetcher()
        do{
            let request = try URLRequestBuilder(with: objectID).build()
            networking.image(request) { (result:Result<UIImage, DataStoreError>) in
                switch result{
                case .success(let image): completion(.success(image))
                case .failure(let error): completion(.failure(error))
                }
            }
        }catch{
            completion(.failure(error as! DataStoreError))
        }
        
    }
    
}
