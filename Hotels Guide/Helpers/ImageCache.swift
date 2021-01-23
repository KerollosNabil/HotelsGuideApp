//
//  ImageCache.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit

protocol ImageCacheType: class {
    // Returns the image associated with a given url
    func image(for id: String) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for id: String)
    // Removes the image of the specified url in the cache
    func removeImage(for id: String)
    // Accesses the value associated with the given key for reading and writing
    subscript(_ id: String) -> UIImage? { get set }
}
class ImageCache {

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}
extension ImageCache: ImageCacheType {
    
    func insertImage(_ image: UIImage?, for id: String) {
        guard let image = image else { return removeImage(for: id) }

        imageCache.setObject(image as AnyObject, forKey: id as AnyObject)
    }

    func removeImage(for id: String) {
        imageCache.removeObject(forKey: id as AnyObject)
    }
    func image(for id: String) -> UIImage? {
        if let image = imageCache.object(forKey: id as AnyObject) as? UIImage {
            return image
        }
        return nil
    }
    subscript(_ id: String) -> UIImage? {
        get {
            return image(for: id)
        }
        set {
            return insertImage(newValue, for: id)
        }
    }
}
