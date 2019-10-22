//
//  ContactDetailHeaderView.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailHeaderView: UIView {
    
    @IBOutlet weak var contactProfileImageView: UIImageView!
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var contactuserNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contactProfileImageView.layer.cornerRadius = contactProfileImageView.frame.size.width/2
    }
    
    func setContactValues(contact: Contact) {
        if let name = contact.name {
            self.contactNameLbl.text = name
        }
        if let userName = contact.username {
            self.contactuserNameLbl.text = userName
        }
    }
}
