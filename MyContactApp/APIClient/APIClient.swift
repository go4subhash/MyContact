//
//  APIClient.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Alamofire

struct ImageDic {
    var filename: String!
    var data: Data!
    var key: ImageParam = .none
    var mimeType: MimeType = .png
    init(_ filename: String? =  nil,
         data: Data,
         key: ImageParam,
         mimeType: MimeType? = nil) {
        self.filename = filename ??  "img\(Float.random(in: 1..<10000))).png"
        self.data = data
        self.key = key
        self.mimeType = mimeType ?? .png
    }
    enum MimeType: String {
        case png = "image/png"
    }
}


class APIClient: NSObject {

    private let sessionManager: SessionManager?
    private let retrier: APIManagerRetrier?

    // MARK: - Public methods

    func request(path: APIRouter,
                 handler: @escaping (Swift.Result<(), CustomError>) -> Void) {
        self.sessionManager?.request(path).validate().responseJSON { [weak self] (data) in
            switch data.result {
            case .success:
                guard let statusCode = data.response?.statusCode
                else {
                    handler(.failure(self?.parseApiError(data: data.data) ?? CustomError()))
                    return
                }
                if statusCode < APIResponseCode.successMinRange.rawValue ||
                    statusCode > APIResponseCode.successMaxRange.rawValue {
                } else {
                    handler(.success(()))
                }
            case .failure:
                handler(.failure(self?.parseApiError(data: data.data) ?? CustomError()))
            }
        }
    }

    func request(path: APIRouter,
                 handler: @escaping (Swift.Result<Bool, CustomError>) -> Void) {

        self.sessionManager?.request(path).validate().responseJSON { (data) in
            switch data.result {
            case .success:
                handler(.success(true))
            case .failure:
                handler(.failure(self.parseApiError(data: data.data)))
            }
        }
    }

    func request<T: Codable>(path: APIRouter,
                             handler: @escaping (Swift.Result<T, CustomError>) -> Void) {
        self.sessionManager?.request(path).validate().responseJSON { (data) in
            switch data.result {
            case .success:
                do {
                    guard let jsonData = data.data,
                          let statusCode = data.response?.statusCode else {
                        throw CustomError(message: nil, code: nil)
                    }
                    let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print("RESPONSE: \(jsonResponse as AnyObject)")
                    if statusCode < APIResponseCode.successMinRange.rawValue ||
                       statusCode > APIResponseCode.successMaxRange.rawValue {
                        self.resetNumberOfRetries()
                        throw self.parseApiError(data: jsonData)
                    } else {
                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        self.resetNumberOfRetries()
                        handler(.success(result))
                    }
                } catch {
                    if let error = error as? CustomError {
                        handler(.failure(error))
                    }
                    handler(.failure(self.parseApiError(data: data.data)))
                }
            case .failure:
                if data.response?.statusCode == 401 {
                    // ###### Log out the user
                }
                handler(.failure(self.parseApiError(data: data.data)))
            }
        }
    }

    func request<T: Codable>(path: APIRouter,
                             imageDic: [ImageDic]?,
                             handler: @escaping (Swift.Result<T, CustomError>) -> Void) {
        self.sessionManager?.upload(multipartFormData: { multipartFormData in
            if let imageDic = imageDic {
                for obj in imageDic {
                    multipartFormData.append(obj.data,
                                             withName: obj.key.rawValue,
                                             fileName: obj.filename,
                                             mimeType: obj.mimeType.rawValue )
                }
            }
            for (key, value) in path.parameters ?? [:] {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key )
            }
        }, with: path) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseData(completionHandler: { (data) in
                    switch data.result {
                    case .success:
                        do {
                            guard let jsonData = data.data,
                                  let statusCode = data.response?.statusCode else {
                                throw CustomError(message: nil, code: nil)
                            }
                            let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                            debugPrint("RESPONSE: \(jsonResponse as AnyObject)")
                            if statusCode < APIResponseCode.successMinRange.rawValue ||
                                statusCode > APIResponseCode.successMaxRange.rawValue {
                                self.resetNumberOfRetries()
                                throw self.parseApiError(data: jsonData)
                            } else {
                                let result = try JSONDecoder().decode(T.self, from: jsonData)
                                self.resetNumberOfRetries()
                                handler(.success(result))
                            }
                        } catch {
                            debugPrint(error)
                            if let error = error as? CustomError {
                                handler(.failure(error))
                            }
                            handler(.failure(self.parseApiError(data: data.data)))
                        }
                    case .failure:
                        handler(.failure(self.parseApiError(data: data.data)))
                    }
                })
            case .failure(let error):
                debugPrint(error)
                if let error = error as? CustomError {
                    handler(.failure(error))
                } else {
                    handler(.failure(CustomError()))
                }
            }
        }
    }

    // MARK: - Private methods

    private func resetNumberOfRetries() {
        retrier?.numberOfRetries = 0
    }

    private func parseApiError(data: Data?) -> CustomError {
        let decoder = JSONDecoder()
        if let jsonData = data,
           let error = try? decoder.decode(ErrorObj.self,
                                           from: jsonData) {
            return CustomError(message: error.message,
                               code: error.code)
        }
        return CustomError(message: nil, code: nil)
    }

    // MARK: - Initialization

    init(sessionManager: SessionManager? = SessionManager(),
         retrier: APIManagerRetrier? = APIManagerRetrier()) {
        self.sessionManager = sessionManager
        self.retrier = retrier
        self.sessionManager?.retrier = self.retrier
    }

    deinit {
        debugPrint("API Client Deinit")
    }
}
