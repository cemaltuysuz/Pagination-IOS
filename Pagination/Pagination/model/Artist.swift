//
//  Artist.swift
//  Pagination
//
//  Created by cemal tüysüz on 24.03.2022.
//

import Foundation

struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name: String
    let type: ArtistType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

struct ExternalUrls: Codable {
    let spotify: String
}

enum ArtistType: String, Codable {
    case artist = "artist"
}
