//
//  Trending.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

struct Trending: Codable {

    let smokeArea: Int
    let active: Int
    let trending: Int
    let telephone: String
    let bat: Int
    let hasQRCode: Int
    let lon: Double
    let shareLink: String
    let city: String
    let pictureURL: String
    let opened: Bool
    let name: String
    let type: String
    let id: Int
    let subtitle: String
    let web: String
    let promoted: Int
    let lat: Double
    let primaryTagGroup: String
    let address: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case active, trending, telephone, bat, lon, city, opened, name, type, id, subtitle, web, promoted, lat, address, description
        case smokeArea = "smoking_area"
        case hasQRCode = "has_qr_code"
        case shareLink = "share_link"
        case pictureURL = "picture_url"
        case primaryTagGroup = "primary_tag_group"
    }
}
