//
//  API.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import Alamofire
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

private let logOptions: NetworkLoggerPlugin.Configuration.LogOptions = [.requestMethod,
                                                                        .requestHeaders,
                                                                        .requestBody,
                                                                        .formatRequestAscURL,
                                                                        .successResponseBody,
                                                                        .errorResponseBody]
private let apiProvider = MoyaProvider<APIRequest>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                                                      logOptions: logOptions))])

extension MoyaError {
    var underlyingEror: Error {
        switch self {
        case .encodableMapping: return self
        case .imageMapping: return self
        case .jsonMapping: return self
        case .objectMapping: return self
        case .parameterEncoding: return self
        case .requestMapping: return self
        case .statusCode: return self
        case .stringMapping: return self
        case .underlying(let error, _): return error
        }
    }
}

struct API {
    @discardableResult
    private static func request<T: Decodable>(request: APIRequest, decoder: JSONDecoder = JSONDecoder(),
                                              completion: @escaping ((Result<T, Error>)) -> Void) -> Cancellable {
        let serverDateFormatter = DateFormatter()
        serverDateFormatter.calendar = Calendar(identifier: .gregorian)
        serverDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        serverDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(serverDateFormatter)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return apiProvider.request(request) { (moyaResult) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let result: Swift.Result<T, Error>
            switch moyaResult {
            case .failure(let moyaError):
                result = Swift.Result<T, Error>.failure(moyaError.underlyingEror)
            case .success(let moyaResponse):
                do {
                    let response: AppResponse<T> = try moyaResponse.map(AppResponse<T>.self, using: jsonDecoder, failsOnEmptyData: false)
                    if let objResult = response.data {
                        result = Swift.Result<T, Error>.success(objResult)
                    } else {
                        let errorMsg = "Unknown error!!!"
                        let nsError = NSError(domain: Bundle.main.bundleIdentifier ?? "",
                                              code: 999,
                                              userInfo: [NSLocalizedDescriptionKey: errorMsg])
                        let moyaError = MoyaError.underlying(nsError, nil)
                        result = Swift.Result<T, Error>.failure(moyaError.underlyingEror)
                    }
                } catch let error {
                    guard let moyaError = error as? MoyaError else {
                        fatalError("Imposible case")
                    }
                    result = Swift.Result<T, Error>.failure(moyaError.underlyingEror)
                }
            }
            completion(result)
        }
    }
}

extension API {
    static func getVenueDashBoard(completion: @escaping (Result<VenueDashBoard, Error>) -> Void) {
        request(request: .venueDashboard, completion: completion)
    }
}

class AppResponse<Result: Decodable>: Decodable {
    let data: Result?

    private enum CodingKeys: String, CodingKey {
        case data
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(Result.self, forKey: .data)
    }
}
