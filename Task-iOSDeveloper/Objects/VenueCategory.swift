//
//  VenueCategory.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

struct VenueCategory: Codable {

    let popularTags: [PopularTag]
    let id: Int
    let feelingLuckyData: [FeelingLuckyData]
    let gradientColorStart: String
    let image: String
    let gradientColorEnd: String
    let feelingLuckyTitle: String
    let feelingLucky: Int
    let categoryAny: String
    let smokingArea: SmokeArea
    let name: String

    enum CodingKeys: String, CodingKey {
        case popularTags, id, feelingLuckyData, image, categoryAny, smokingArea, name
        case gradientColorStart = "gradient_color_start"
        case gradientColorEnd = "gradient_color_end"
        case feelingLuckyTitle = "feeling_lucky_title"
        case feelingLucky = "feeling_lucky"
    }
}

struct FeelingLuckyData: Codable {

    let anyTitle: String
    let id: Int
    let tagGroup: TagGroup
    let order: Int
    let categoryId: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id, tagGroup, order, title
        case anyTitle = "any_title"
        case categoryId = "category_id"
    }
}
