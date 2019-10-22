//
//  ContactViewModel.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

class ContactViewModel {
    
    var dataSource = ContactDataSource()
    var contactAPIRepository = ContactAPIRepository()
    private var contactList: [Contact]?
    
    func getContactList(completion: ((Bool, CustomError?) -> Void)?) {
        // API initialisation
        
        let contactListRouter = APIRouter.fetchContact(urlQuery: "") // initialse ROUTER with all paramenter and tequest type
        contactAPIRepository.fetchContactList(with: contactListRouter) { (contactList, error) in
            if contactList != nil || error == nil {
                if let cList = contactList {
                    // handle response data
                    self.contactList = cList
                    self.sortAtoZ()
                    completion?(true, nil)
                }
            } else {
                 completion?(false, error)
            }
        }
    }
    func createGroupDataSource(contactData: [Contact]) -> [[Contact]]{
       // create single dimetion contact array to multi dimetion contact arrary. Grouped the item based on their first charchater.
        
        let groupedContacts = contactData.reduce([[Contact]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.name?.first == $1.name?.first {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                collection += [[$1]]
            }
            return collection
        }
       return groupedContacts
    }
    
    func sortAtoZ() {
        // sort and create contacts datasource  in accending order
        
        if let contacts = self.contactList {
            let sortedContacts = contacts.sorted { $0.name ?? "" < $1.name ?? "" }
            let groupedList = self.createGroupDataSource(contactData: sortedContacts)
            self.dataSource.isListSortedDescending = false
            self.dataSource.addContactData(data: groupedList)
        }
    }
    func sortZtoA() {
        // sort and create contacts datasource in descending order
        
        if let contacts = self.contactList {
            let sortedContacts = contacts.sorted { $0.name ?? "" > $1.name ?? "" }
           let groupedList = self.createGroupDataSource(contactData: sortedContacts)
            self.dataSource.isListSortedDescending = true
            self.dataSource.addContactData(data: groupedList)
        }
    }
    func showSearchResultForText(searchText: String) {
        // search query and create searched data source
        
        if let listData = self.contactList {
            if searchText.count > 0 {
                let result = listData.filter { (contact) -> Bool in
                    return contact.name?.lowercased().contains(searchText.lowercased()) ?? false
                }
                dataSource.showSearchResultData(searchList: result)
            } else {
                dataSource.showSearchResultData(searchList: listData)
            }
        }
    }
    func searchCompleted() {
        // clear the search result
        
        dataSource.isSearchActive = false
    }
}
