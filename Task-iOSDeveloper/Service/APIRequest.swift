//
//  APIRequest.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import Alamofire
import Moya

enum APIRequest {
    case venueDashboard
}


extension APIRequest: TargetType {
    
    // MARK: - Base URL
    public var baseURL: URL {
        do {
            return try EndPoint.baseUrl.asURL()
        } catch {
            fatalError("Please set Base URL")
        }
    }
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .venueDashboard:
            return "/venue/dashboard"
        }
    }
    
    // MARK: - Method
    public var method: Moya.Method {
        switch self {
        case .venueDashboard:
            return .get
        }
    }
    
    // MARK: - Task
    public var task: Task {
        switch self {
        case .venueDashboard:
            return .requestPlain
        }
    }
    
    // MARK: - Validation
    public var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    // MARK: - Sample Data
    public var sampleData: Data {
        return Data()
    }
    
    // MARK: - Headers
    public var headers: [String: String]? {
        let parameters = [APIKey.contentType: "application/json",
                          APIKey.language: "en"]
        
        return parameters
    }
}
