//
//  LocalStore.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

protocol LocalStore {
    associatedtype StoredObject

    func find(_ objectID: String, completion: @escaping (Result<StoredObject, DataStoreError>) -> Void)
    func persist(_ object: StoredObject, objectID: String)
}

