//
//  RemoteStore.swift
//  Hotels Guide
//
//  Created by MAC on 21/01/2021.
//

import Foundation

protocol RemoteStore {
    associatedtype TargetObject: Decodable

    var network: Networking { get }
    func find(_ objectID: String, completion: @escaping (Result<TargetObject, DataStoreError>) -> Void)
}
