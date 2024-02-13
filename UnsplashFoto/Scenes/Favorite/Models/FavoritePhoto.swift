//
//  FavoritePhoto.swift
//  UnsplashFoto
//
//  Created by Владислав on 13.02.2024.
//

import Foundation

struct FavoritePhoto: Codable {
    let id: String?
    let imageUrl: String?
    let authorName: String?
    let downloadCount: Int?
}
