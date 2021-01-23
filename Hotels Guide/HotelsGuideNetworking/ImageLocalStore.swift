//
//  ImageLocalStore.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit

struct ImageLocalStore:LocalStore {
    static let shared = ImageLocalStore()
    private let imageCacher = ImageCache()
    func find(_ objectID: String, completion: @escaping (Result<UIImage, DataStoreError>) -> Void) {
        
        if let image = imageCacher.image(for:  objectID) {
            completion(.success(image))
        }else{
            completion(.failure(DataStoreError.failed))
        }
    }
    func persist(_ object: UIImage, objectID: String) {
        imageCacher.insertImage(object, for: objectID)
    }
}
