//
//  UIImageView + Extension.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Alamofire
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from urlString: String) {
        let urlKey = NSString(string: urlString)
        
        if let cachedImage = imageCache.object(forKey: urlKey) {
            self.image = cachedImage
            return
        }
        
        AF.request(urlString).responseData { [weak self] response in
            if let error = response.error {
                print("Ошибка при загрузке изображения: \(error)")
                return
            }
            guard let data = response.data, !data.isEmpty else {
                print("Отсутствуют данные изображения или они пустые")
                return
            }
            guard let downloadedImage = UIImage(data: data) else {
                print("Невозможно создать изображение из полученных данных")
                return
            }
            DispatchQueue.main.async {
                imageCache.setObject(downloadedImage, forKey: urlKey)
                self?.image = downloadedImage
            }
        }
    }
}
