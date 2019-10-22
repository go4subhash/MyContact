//
//  ContactModel.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation

// coadable object for contact resullt
typealias Response = [Contact]

struct Contact: Codable {
    var contact_id: Int?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    var company: Company?
    var address: Address?
}

struct Company: Codable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

struct Address: Codable {
    var city: String?
    var street: String?
    var suite: String?
    var zipcode: String?
    var geo: GeoLocation?
}

struct GeoLocation: Codable {
    var lat: String?
    var lng: String?
}
