//
//  APIConstents.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case deviceId = "device-id"
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
    case bearer
}

struct ErrorObj: Codable {

    var message: String?
    var code: Int?

    private enum CodingKeys: String, CodingKey {
        case message = "detail"
        case code = "status_code"
    }
}
// CustomError Object model call when API fail.
struct CustomError: OurErrorProtocol {
    var message: String?
    var code: Int?
}

protocol OurErrorProtocol: LocalizedError {
    var message: String? { get }
    var code: Int? { get }
}
enum APIResponseCode: Int {
    case successMinRange = 200
    case successMaxRange = 299
    case notFound = 404
}
enum ImageParam: String {
    case none
    case image
    case profileImage = "profile_picture"
    case documentFront = "document_front"
    case documentBack = "document_back"
}
