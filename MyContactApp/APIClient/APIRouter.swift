//
//  APIRouter.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Alamofire

let kBaseUrl = "https://jsonplaceholder.typicode.com"

enum APIRouter: URLRequestConvertible {
    case fetchContact(urlQuery: String)
    case none
    public var baseURL: String {
        return kBaseUrl
    }
    public var queryBaseURL: String {
        return kBaseUrl
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        if baseUrl == queryBaseURL {
            urlRequest = URLRequest(url: URL(string: String(format: "%@%@", queryBaseURL, urlQuery))!)
        } else {
            urlRequest = URLRequest(url: URL(string: String(format: "%@%@%@", baseURL, path, urlQuery))!)
        }
        debugPrint("REQUEST: \(urlRequest.url?.absoluteString ?? "Invalid Request")")
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        print("HEADER PARAM: \(header ?? [:])")
        if let queryParam = header {
            for (key, value) in queryParam {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        // Parameters
        guard let parameters = parameters else {
            return urlRequest
        }
        print("QUERY PARAM: \(parameters)")
        return  try encoding.encode(urlRequest, with: parameters)
    }
}

// MARK: - HTTPMethod
extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .fetchContact:
            return .get
        case .none:
            return .post
        }
    }
}

// MARK: - ParameterEncoding
extension APIRouter {
    var encoding: ParameterEncoding {
        switch self {
        case .fetchContact:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
// MARK: - BaseUrl
extension APIRouter {
    var baseUrl: String {
        switch self {
        case .fetchContact:
            return baseURL
        default:
            return queryBaseURL
        }
    }
}
// MARk: - ContentType
extension APIRouter {
    var contentType: String {
        switch self {
        case .fetchContact:
            return ContentType.json.rawValue
        case .none:
            return ContentType.formData.rawValue
        }
    }
}

// MARK: - Path
extension APIRouter {
    var path: String {
        switch self {
        case .fetchContact:
            return "/users"
        case .none:
            return ""
        }
    }
}

extension APIRouter {
    var urlQuery: String {
        switch self {
        case .fetchContact:
            return "/users"
        default:
            return ""
        }
    }
}

// MARK: - HTTPHeaders
extension APIRouter {

    var header: HTTPHeaders? {
        var headerParam: [String: String] = [:]
        headerParam[HTTPHeaderField.contentType.rawValue] = contentType
        headerParam[HTTPHeaderField.authorization.rawValue] = ContentType.bearer.rawValue + " " + ""
       
        return headerParam
    }
}

extension APIRouter {
    var parameters: Parameters? {
            return nil
    }
}
