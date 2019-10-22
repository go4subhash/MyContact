//
//  ContactAPIRespositry.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation

protocol ContactAPIProtocol {

    func fetchContactList(with router: APIRouter,
                          completion: (([Contact]?, CustomError?) -> Void)?)
}

extension ContactAPIProtocol {

func fetchContactList(with router: APIRouter,
                      completion: (([Contact]?, CustomError?) -> Void)?) {
    // fetch contact API call
       APIClient().request(path: router) { (response: Swift.Result<Response ,
           CustomError>) in

           switch response {
           case .success(let result):
            if  result != nil {
                completion?(result, nil)
            } else {
                   let error = CustomError(message: AlertMessage.unknowError.rawValue, code: nil)
                   completion?(nil, error)
                   return
               }
               
           case .failure(let error):
               completion?(nil, error)
           }
       }
   }
}
struct ContactAPIRepository: ContactAPIProtocol {
}
