//
//  Response.swift
//  Pagination
//
//  Created by cemal tüysüz on 24.03.2022.
//

import Foundation

struct AlbumsResponse: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: String
    let offset: Int
    var previous: String? = nil
    let total: Int
}
