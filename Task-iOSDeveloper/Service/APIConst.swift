//
//  ApiConst.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import Foundation

struct EndPoint {
    static let api = "https://api.ajmo.hr/v3"
    
    static var baseUrl: String {
        return EndPoint.api
    }
}

struct APIKey {
    static let authorization = "Authorization"
    static let language = "Accept-Language"
    static let contentType = "Content-Type"
}
