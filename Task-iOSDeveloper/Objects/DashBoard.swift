//
//  DashBoard.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

struct VenueDashBoard: Codable {

    let trending: Int
    let pickOfTheWeek: Double
    let venueCategories: Double
    let customPicks: Int

    enum CodingKeys: String, CodingKey {
        case trending, pickOfTheWeek, venueCategories, customPicks
    }
}
