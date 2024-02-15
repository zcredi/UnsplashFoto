//
//  UnsplashPhotoModel.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String?
    let slug: String?
    let createdAt: String?
    let updatedAt: String?
    let promotedAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: PhotoUrls?
    let links: PhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let user: User
    let exif: Exif?
    let location: Location?
    let views: Int?
    let downloads: Int?
    let tags: [Tag]?
    let tagsPreview: [TagPreview]?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, width, height, color, description, urls, links, likes, user, exif, location, views, downloads, tags
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
        case tagsPreview = "tags_preview"
    }
}

struct PhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct PhotoLinks: Codable {
    let selfLink: String
    let html: String
    let download: String
    let downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct User: Codable {
    let id: String
    let updatedAt: String
    let username: String
    let name: String
    let first_name: String
    let last_name: String?
    let twitter_username: String?
    let portfolio_url: String?
    let bio: String?
    let location: String?
    let links: UserLinks
    let profile_image: UserProfileImage
    let instagram_username: String?
    let total_collections: Int
    let total_likes: Int
    let total_photos: Int
    let accepted_tos: Bool
    let for_hire: Bool
    let social: UserSocial
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, location, links, bio
        case updatedAt = "updated_at"
        case first_name, last_name, twitter_username, portfolio_url, profile_image, instagram_username, total_collections, total_likes, total_photos, accepted_tos, for_hire, social
    }
}

struct UserLinks: Codable {
    let selfLink: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    let following: String
    let followers: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

struct UserProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

struct UserSocial: Codable {
    let instagram_username: String?
    let portfolio_url: String?
    let twitter_username: String?
    let paypal_email: String?
}

struct Exif: Codable {
    let make: String?
    let model: String?
    let exposureTime: String?
    let aperture: String?
    let focalLength: String?
    let iso: Int?
    
    enum CodingKeys: String, CodingKey {
        case make, model
        case exposureTime = "exposure_time"
        case aperture, focalLength = "focal_length", iso
    }
}

struct Location: Codable {
    let name: String?
    let city: String?
    let country: String?
    let position: Position?
}

struct Position: Codable {
    let latitude: Double?
    let longitude: Double?
}

struct Tag: Codable {
    let type: String?
    let title: String?
}

struct TagPreview: Codable {
    let type: String?
    let title: String?
}
