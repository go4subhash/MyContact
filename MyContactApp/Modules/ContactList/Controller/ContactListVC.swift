//
//  ContactListVC.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import UIKit

class ContactListVC: BaseVC {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sortAscendingBtn: UIButton!
    @IBOutlet weak var sortDescendingingBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactListTblView: UITableView!
    private let kViewControllerTitle = "Contacts"
    private var viewModel = ContactViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupDataSourceView()
        self.setupSearchBar()
        self.fetchContactList()
    }
    
    private func setupDataSourceView() {
        // initialise table view and their datasource and delegate
        
        contactListTblView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifierString.contactCellIdentifier.rawValue)
        let dataSource = viewModel.dataSource
        dataSource.delegate = self
        contactListTblView.dataSource = dataSource
        contactListTblView.delegate = dataSource
        contactListTblView.rowHeight = UITableView.automaticDimension
    }
    private func setupSearchBar() {
        // initilise and setup the search bar delegate
        self.searchBar.delegate = self
    }
    private func fetchContactList() {
        // fetch list of contact from server
        if ConnectivityUtils.isConnectedToNetwork() == false {
            showNoNetworkAlert()
            showEmptyView(.noNetwork)
            return
        }
        Loader.addLoader(view)
        viewModel.getContactList { (value, error)  in
            Loader.removeLoader()
            if value == true {
                self.contactListTblView.reloadData()
            } else {
                // show error message
                
            }
        }
    }
    @IBAction func sortContactAscending(_ sender: Any) {
        // sort contact list in Ascending order
        viewModel.sortAtoZ()
        self.contactListTblView.reloadData()
    }
    @IBAction func sortContactDecending(_ sender: Any) {
        // sort contact list in Descending order
        viewModel.sortZtoA()
        self.contactListTblView.reloadData()
    }
    func activeDeactiveSearchUI(value: Bool) {
        // UI change on active or deactive search controller
        self.sortAscendingBtn.isHidden = value
        self.sortDescendingingBtn.isHidden = value
        searchBar.showsCancelButton = value
    }
}

extension ContactListVC: ContactDataSourceProtocol {
    func selectedContact(contact: Contact?) {
        // table view did select delegate for contact list
       if viewModel.dataSource.isSearchActive {
            self.view.endEditing(true)
        }
        if let cont = contact {
            AppFlowCoordinator.loadContactDetailViewController { controller in
                controller.setContact(contact: cont)
            }
        }
       
    }
}

extension ContactListVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // initialse search
        self.activeDeactiveSearchUI(value: true)
        viewModel.showSearchResultForText(searchText: "")
        self.contactListTblView.reloadData()
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // clear the search
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.activeDeactiveSearchUI(value: false)
        self.viewModel.searchCompleted()
        self.contactListTblView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // refine the search result
        print(searchText)
        viewModel.showSearchResultForText(searchText: searchText)
        self.contactListTblView.reloadData()
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        // on search button click handling
        self.view.endEditing(true)
        viewModel.searchCompleted()
        self.contactListTblView.reloadData()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // regisn keyboard on click on view
        self.view.endEditing(true)
    }
}
