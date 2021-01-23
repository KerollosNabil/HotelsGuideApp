//
//  UIImageView+Extention.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit

extension UIImageView {
    func feachImage(urlString:String, completion:((Bool)->Void)? = nil){
        let remoteFeacher = ImageRemoteStore()
        let localFeacher = ImageLocalStore.shared
        let imageFeacher = CacheBackedDataSource(localStore:localFeacher,remoteStore: remoteFeacher)
        imageFeacher.find(urlString) {[weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let image):
                DispatchQueue.main.async {
                    print(self.bounds)
                    self.image = image
                    
                    completion?(true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion?(false)
                }
            }
            
        }
    }
}
