//
//  APIManagerRetriver.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import Alamofire

class APIManagerRetrier: RequestRetrier {

    // MARK: - Vars & Lets

    var numberOfRetries = 0
    let abortConnection = "The operation couldn’t be completed. Software caused connection abort"
    // MARK: - Request Retrier methods

    func should(_ manager: SessionManager,
                retry request: Request,
                with error: Error,
                completion: @escaping RequestRetryCompletion) {
        if error.localizedDescription == abortConnection {
            completion(true, 1.0) // retry after 1 second
            numberOfRetries += 1
        } else if let response = request.task?.response as? HTTPURLResponse,
            response.statusCode >= 500,
            numberOfRetries < 3 {
            completion(true, 1.0) // retry after 1 second
            numberOfRetries += 1
        } else {
            completion(false, 0.0) // don't retry
            numberOfRetries = 0
        }
    }
}
