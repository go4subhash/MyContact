//
//  ContactDetailCell.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var keyNameLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    func setLableValues(key: String, value: String) {
        self.keyNameLbl.text = key
        self.valueLbl.text = value
        
    }
}
