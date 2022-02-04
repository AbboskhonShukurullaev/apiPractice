//
//  Post.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation

struct PostUserProfileImage: Codable {
    let medium: String
}

struct PostUser: Codable {
    let profile_image: PostUserProfileImage
    let name: String?
}

struct PostUrls: Codable {
    let regular: String
}

struct Post: Codable {
    let id: String
//    let created_at: Date
    let description: String?
    let likes: Int
    let user: PostUser
    let urls: PostUrls
}


//struct Welcome: Codable {
//    let id: String
//    let createdAt, updatedAt: Date
//    let width, height: Int
//    let color: String
//    let likes: Int
//    let user: User
//    let urls: Urls
//    let links: WelcomeLinks
//    let location: Location
//    let exif: Exif
//    let views, downloads: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case width, height, color, likes, user, urls, links, location, exif, views, downloads
//    }
//}
//
//// MARK: - Exif
//struct Exif: Codable {
//    let make, model, exposureTime, aperture: String
//    let focalLength: String
//    let iso: Int
//
//    enum CodingKeys: String, CodingKey {
//        case make, model
//        case exposureTime = "exposure_time"
//        case aperture
//        case focalLength = "focal_length"
//        case iso
//    }
//}
//
//// MARK: - WelcomeLinks
//struct WelcomeLinks: Codable {
//    let linksSelf, html, download, downloadLocation: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, download
//        case downloadLocation = "download_location"
//    }
//}
//
//// MARK: - Location
//struct Location: Codable {
//    let name, city, country: String
//    let position: Position
//}
//
//// MARK: - Position
//struct Position: Codable {
//    let latitude, longitude: Double
//}
//
//// MARK: - Urls
//struct Urls: Codable {
//    let raw, full, regular, small: String
//    let thumb: String
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: String
//    let updatedAt: Date
//    let username, name, firstName, lastName: String
//    let twitterUsername: String
//    let portfolioURL: String
//    let bio, location: String
//    let links: UserLinks
//    let profileImage: ProfileImage
//    let totalCollections: Int
//    let instagramUsername: String
//    let totalLikes, totalPhotos: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case updatedAt = "updated_at"
//        case username, name
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case twitterUsername = "twitter_username"
//        case portfolioURL = "portfolio_url"
//        case bio, location, links
//        case profileImage = "profile_image"
//        case totalCollections = "total_collections"
//        case instagramUsername = "instagram_username"
//        case totalLikes = "total_likes"
//        case totalPhotos = "total_photos"
//    }
//}
//
//// MARK: - UserLinks
//struct UserLinks: Codable {
//    let linksSelf, html, photos, likes: String
//    let portfolio, following, followers: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, photos, likes, portfolio, following, followers
//    }
//}
//
//// MARK: - ProfileImage
//struct ProfileImage: Codable {
//    let small, medium, large: String
//}
