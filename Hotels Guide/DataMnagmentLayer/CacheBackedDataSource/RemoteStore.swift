//
//  RemoteStore.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

protocol RemoteStore {
    associatedtype TargetObject

    func find(_ objectID: String, completion: @escaping (Result<TargetObject, DataStoreError>) -> Void)
}
