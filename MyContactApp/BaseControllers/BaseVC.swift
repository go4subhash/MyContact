//
//  BaseVC.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

enum EmptyViewType {
    case noNetwork
    case noData
}

class BaseVC: UIViewController {
    
    private var emptyView: EmptyView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print("Base Controller has been deallocated")
        NotificationCenter.default.removeObserver(self)
    }
    func showNoNetworkAlert() {
        // show no network alert messages
        
        let alertController = UIAlertController(title: AlertTitle.noInternet.rawValue,
                                                message: AlertMessage.noInternet.rawValue,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertButtonTitle.okText.rawValue,
                                                style: .default,
                                                handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func removeEmptyView() {
        // remove empty veiew from controller
        
        guard let emptyView = self.emptyView  else { return }
        emptyView.removeFromSuperview()
        self.emptyView = nil
    }

    func showEmptyView(_ type: EmptyViewType,
                        for parentView: UIView? = nil,
                        noDataText: String? = nil,
                        noDataSubTitle: String? = nil,
                        topMargin: CGFloat = 0,
                        bottomMargin: CGFloat = 0) {
        // show empty view on view controller if no result found
        
        removeEmptyView()
        var localView: UIView! = view
        if let viewObj = parentView {
            localView = viewObj
        }
        let emptyView = getEmptyView(type,
                                    for: parentView,
                                    noDataText: noDataText,
                                    noDataSubTitle: noDataSubTitle)
        localView.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: localView.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: localView.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: localView.topAnchor, constant: topMargin).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: localView.bottomAnchor, constant: -bottomMargin).isActive = true
    }

    func getEmptyView(_ type: EmptyViewType,
                        for parentView: UIView? = nil,
                        noDataText: String? = nil,
                        noDataSubTitle: String? = nil) -> EmptyView {
        // initialise empty view
        
        removeEmptyView()
        var localView: UIView! = view
        if let viewObj = parentView {
            localView = viewObj
        }
        emptyView = EmptyView.loadNib()
        emptyView.frame = CGRect(x: 0, y: 0, width: localView.frame.width, height: localView.frame.height)
        if type == .noData{
            // empty view for no data
            emptyView.emptyLogoImgView.image = UIImage(named: EmptyViewImageName.noData.rawValue)
            emptyView.emptyTitleLbl.text = EmptyViewTitle.noData.rawValue
            emptyView.emptyDescriptionLbl.text = EmptyViewDescription.noData.rawValue
        } else {
            // empty view for no network
            
            emptyView.emptyLogoImgView.image = UIImage(named: EmptyViewImageName.noNetwork.rawValue)
            emptyView.emptyTitleLbl.text = EmptyViewTitle.noNetwork.rawValue
            emptyView.emptyDescriptionLbl.text = EmptyViewDescription.noNetwork.rawValue
        }
        return emptyView
    }

}
