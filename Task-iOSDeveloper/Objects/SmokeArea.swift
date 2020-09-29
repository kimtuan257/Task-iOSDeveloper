//
//  SmokeArea.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

struct SmokeArea: Codable {

    let title: String
    let answers: Answer

    enum CodingKeys: String, CodingKey {
        case title, answers
    }
}

struct Answer: Codable {
    let one: String
    let zero: String
    let minusOne: String

    enum CodingKeys: String, CodingKey {
        case one = "1"
        case zero = "0"
        case minusOne = "-1"
    }
}
