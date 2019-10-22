//
//  ContactListDataSource.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDataSourceProtocol: NSObjectProtocol {
    func selectedContact(contact: Contact?)
}

class ContactDataSource: NSObject, UITableViewDataSource {
    weak var delegate: ContactDataSourceProtocol?
    private var sectionKeys: [String] = [] // contains list of section key to show indexs in tableview
    private var tblDataSource: [[Contact]]? // contains list of contact
    private var searchDataSource: [Contact]? // contains search data
    var isSearchActive = false
    var isListSortedDescending = false
    private let kSearchHeaderTitle = "Search Result"
    private let kSearchNoResultTitle = "No result found"

    func addContactData(data: [[Contact]]) {
        // add and initialse list of contact
        
        self.sectionKeys.removeAll()
        self.tblDataSource = data
    }
    
    func showSearchResultData(searchList: [Contact]) {
        // add and initiase search data source
        
        self.isSearchActive = true
        self.searchDataSource = searchList
        self.sectionKeys.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearchActive {
            return self.searchDataSource?.count ?? 0
        }
        return tblDataSource?[section].count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.isSearchActive {
            return 1
        }
        return tblDataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierString.contactCellIdentifier.rawValue) else {
            return UITableViewCell()
        }
        if self.isSearchActive {
            if let contactObj = self.searchDataSource?[indexPath.row] {
                cell.textLabel?.text = contactObj.name
            }
            return cell
        }
        if let contactObj: Contact = tblDataSource?[indexPath.section][indexPath.row] {
            cell.textLabel?.text = contactObj.name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearchActive {
            if let count  = self.searchDataSource?.count, count > 0 {
                return kSearchHeaderTitle
            } else {
                return kSearchNoResultTitle
            }
        }
        if let obj = tblDataSource?[section].first {
            if let sectionChar = obj.name?.first?.uppercased() {
                self.sectionKeys.append(sectionChar) // add values of section keys to show indexs
                return sectionChar
            }
        }
        return ""
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearchActive {
            return nil
        }
        if isListSortedDescending {
            sectionKeys.sort(by: >) // sort section keys in descending order
        } else {
            sectionKeys.sort() // sort section keys in ascending order
        }
        return sectionKeys
    }
    
}

extension ContactDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedContact: Contact?
        if isSearchActive {
            selectedContact = self.searchDataSource?[indexPath.row] // handled search result contact selection
        } else {
            selectedContact = self.tblDataSource?[indexPath.section][indexPath.row] // handle list contact seelction
        }
        delegate?.selectedContact(contact: selectedContact)
    }
}
