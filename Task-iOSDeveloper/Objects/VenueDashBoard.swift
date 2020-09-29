//
//  VenueDashBoard.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

struct VenueDashBoard: Codable {

    let trending: [Trending]
    let venueCategories: [VenueCategory]

    enum CodingKeys: String, CodingKey {
        case trending, venueCategories
    }
}
