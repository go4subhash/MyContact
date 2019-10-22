//
//  ContactDetailVC.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {

    @IBOutlet weak var contactDetailTblView: UITableView!
    var contactDetailViewModel = ContactDetailViewModel()
    private var currentContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupDataSourceView()
    }
    
    func setContact(contact: Contact) {
        self.currentContact = contact
        self.contactDetailViewModel.dataSource.contact = contact
    }
    private func setupDataSourceView() {
        // initialise table view and their datasource and delegate
        contactDetailTblView.register(with: [ContactDetailCell.self])
        let dataSource = contactDetailViewModel.dataSource
        contactDetailTblView.dataSource = dataSource
        contactDetailTblView.delegate = dataSource
        contactDetailTblView.rowHeight = UITableView.automaticDimension
        if let contact = self.currentContact {
            let header = ContactDetailHeaderView.loadNib()
            header.setContactValues(contact: contact)
            header.frame = CGRect(x: 0, y: 0, width: contactDetailTblView.frame.size.width, height: 180)
            contactDetailTblView.tableHeaderView = header
        }
        
    }
}
