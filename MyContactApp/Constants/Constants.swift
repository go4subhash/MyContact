//
//  Constants.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation

// all string contant used throughout the app
enum Storyboard: String {
    case contactList = "ContactList"
    case contactDetail = "ContactDetail"
}

enum CellIdentifierString: String {
    case contactCellIdentifier = "ContactCell"
    case contactDetailCellIdentifier = "ContactDetailCell"
}

enum AlertMessage: String {
    case unknowError = "Something Went Wrong Please Try Again"
    case noInternet = "Please check your internet connection and try again"
}
enum AlertTitle: String {
    case noInternet = "No Internet Connection"
    case error = "Error"
    case blank = ""
}
enum AlertButtonTitle: String {
    case okText = "OK"
}

enum EmptyViewTitle: String {
    case noNetwork = "Uh-Oh!"
    case noData = "It's All Empty"
}
enum EmptyViewImageName: String {
    case noNetwork = "icons8-no-network-30.png"
    case noData = "icons8-no-record-30.png"
}
enum EmptyViewDescription: String {
    case noNetwork = "Seems like you’ve lost your internet connection. Please check your internet connectivity and try again."
    case noData = "Server is not responding with data. So please try later or contact to data provider."
}
enum PlaceHolderType {
    case noNetwork
    case noDataAvailable
}
enum ContactDetailSequnceEnum: Int {
    case phoneNO = 0
    case email
    case website
    case company
    case address
}
enum ContactDetailKeysEnum: String {
    case phoneNo = "Phone:"
    case email = "Email:"
    case website = "Website:"
    case company = "Office:"
    case address = "Address"
}
