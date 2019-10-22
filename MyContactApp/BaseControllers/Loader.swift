//
//  Loader.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Loader: NSObject {

    static let loaderRadius: CGFloat = 50
    static let baseView: UIView = UIView()
    static var activityIndicatorView: NVActivityIndicatorView!

    class func addLoader(_ view: UIView) {
        removeLoader() // removal of activity indicator before adding to base view, check if already added to base
        baseView.frame = CGRect.zero
        baseView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        activityIndicatorView = NVActivityIndicatorView(frame: .zero,
                                                        type: .circleStrokeSpin,
                                                        color: UIColor.darkGray,
                                                        padding: 0)
        activityIndicatorView.startAnimating()
        baseView.addSubview(activityIndicatorView)
        view.addSubview(baseView)
        udpateConstraint(indicatorView: activityIndicatorView, superView: view)
    }

    class func udpateConstraint(indicatorView: UIView, superView: UIView) {
    
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        baseView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true

        indicatorView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: loaderRadius).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: loaderRadius).isActive = true
    }

    class func removeLoader() {
        // remove loader
        
        if activityIndicatorView != nil {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.removeFromSuperview()
            baseView.removeFromSuperview()
        }
    }
}
