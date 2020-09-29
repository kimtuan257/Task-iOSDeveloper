//
//  Tag.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

struct Tag: Codable {

    let tagGroupId: Int
    let id: Int
    let name: String
    let color: String

    enum CodingKeys: String, CodingKey {
        case id, name, color
        case tagGroupId = "tag_group_id"
    }
}

struct TagGroup: Codable {
    let id: Int
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id, tags
    }
}

struct PopularTag: Codable {

    let tag: Tag
    let tags: Int

    enum CodingKeys: String, CodingKey {
        case tag, tags
    }
}
