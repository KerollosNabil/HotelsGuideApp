//
//  CacheBackedDataSource.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

struct CacheBackedDataSource<Local: LocalStore, Remote: RemoteStore>  where Local.StoredObject == Remote.TargetObject {
    private let localStore: Local
    private let remoteStore: Remote

    func find(_ objectID: String, completion: @escaping (Result<Local.StoredObject, DataStoreError>) -> Void) {
        localStore.find(objectID) { localResult in
            switch localResult{
            case .success(let object):
                completion(.success(object))
            case .failure:
                self.remoteStore.find(objectID) { remoteResult in
                    switch remoteResult{
                    case .success(let object):
                        self.localStore.persist(object)
                        completion(.success(object))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            
        }
    }
    
}
