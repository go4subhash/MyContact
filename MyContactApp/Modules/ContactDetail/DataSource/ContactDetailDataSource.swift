//
//  ContactDetailDataSource.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailDataSource: NSObject, UITableViewDataSource {
    var contact: Contact?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: ContactDetailCell = tableView.dequeueReusableCell(for: indexPath)
        self.showDataAtIndex(indexPath: indexPath, cell: cell)
        return cell
    }
    func showDataAtIndex(indexPath: IndexPath, cell: ContactDetailCell) {
        // show title and value based on pre define indexs
        switch indexPath.row {
        case ContactDetailSequnceEnum.phoneNO.rawValue:
            cell.setLableValues(key: ContactDetailKeysEnum.phoneNo.rawValue, value: contact?.phone ?? "")
        case ContactDetailSequnceEnum.email.rawValue:
            cell.setLableValues(key: ContactDetailKeysEnum.email.rawValue, value: contact?.email ?? "")
        case ContactDetailSequnceEnum.website.rawValue:
            cell.setLableValues(key: ContactDetailKeysEnum.website.rawValue, value: contact?.website ?? "")
        case ContactDetailSequnceEnum.company.rawValue:
            cell.setLableValues(key: ContactDetailKeysEnum.company.rawValue, value: contact?.company?.bs ?? "")
        case ContactDetailSequnceEnum.address.rawValue:
            cell.setLableValues(key: ContactDetailKeysEnum.address.rawValue, value: self.getCombineAddress())
        default:
            cell.setLableValues(key: "", value: "")

        }
    }
    func getCombineAddress() -> String {
        // get full address
        
        var addressStr: String = ""
        if let suite = contact?.address?.suite  {
            addressStr += suite
        }
        if let street = contact?.address?.street {
            if addressStr.count > 0 {
                addressStr += ", "
            }
            addressStr += street
        }
        if let city = contact?.address?.city {
            if addressStr.count > 0 {
                addressStr += ", "
            }
            addressStr += city
        }
        if let zipcode = contact?.address?.zipcode {
            if addressStr.count > 0 {
               addressStr += "- "
            }
            addressStr += zipcode
        }
        return addressStr
    }
}

extension ContactDetailDataSource: UITableViewDelegate {
    
}
