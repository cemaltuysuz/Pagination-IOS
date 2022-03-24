//
//  Item.swift
//  Pagination
//
//  Created by cemal tüysüz on 24.03.2022.
//

import Foundation

struct Item: Codable {
    let albumGroup, albumType: Album
    let artists: [Artist]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name, releaseDate: String
    let releaseDatePrecision: ReleaseDatePrecision
    let totalTracks: Int
    let type: ItemType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case albumGroup = "album_group"
        case albumType = "album_type"
        case artists
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

enum Album: String, Codable {
    case single = "single"
}
enum ItemType: String, Codable {
    case album = "album"
}
enum ReleaseDatePrecision: String, Codable {
    case day = "day"
}

