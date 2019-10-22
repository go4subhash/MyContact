//
//  AppFlowController.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

///
/// This class will only be responsible to help controllers ...
/// ... in navigating between different controllers
///
class AppFlowCoordinator {
    
    // MARK: - Private Init
    private init() { }
    
    private class func getCurrentNavigationController() -> UINavigationController? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        let navigController = delegate.currentNavigationController
        return navigController
    }
    
    class func popToRootViewController() {
        guard let navigationVC = getCurrentNavigationController()
            else { return }
        navigationVC.popToRootViewController(animated: false)
    }
    class func loadController(_ viewController: UIViewController,
                                 navigationController: UINavigationController?,
                                 shouldPresent: Bool = false,
                                 completion: (() -> Void)? = nil,
                                 hideNavigationBar: Bool = false,
                                 shouldPresentAsPopover: Bool = false,
                                 shouldAnimated: Bool = true) {
           
           var navigController = navigationController
           if navigController == nil {
               navigController = getCurrentNavigationController()
           }
           if shouldPresent {
               let navController = BaseNavigationController(rootViewController: viewController)
               navController.isNavigationBarHidden = hideNavigationBar
               if #available(iOS 13.0, *) {
                   navController.isModalInPresentation = true
                   navController.modalPresentationStyle = .fullScreen
               } else {
                   // Fallback on earlier versions
               }
               navigController?.present(navController, animated: shouldAnimated, completion: completion)
           } else {
               navigController?.isNavigationBarHidden = hideNavigationBar
               navigController?.pushViewController(viewController, animated: shouldAnimated)
           }
       }
    
    class func loadContactDetailViewController(_ navigationController: UINavigationController? = nil, shouldPresent: Bool = false, preLoadBlock: ((ContactDetailVC) -> Void)? = nil) {
             
        guard let controller = StoryboardCoordinator.loadContactDetailViewController() else { return }
        preLoadBlock?(controller)
        loadController(controller,
                    navigationController: navigationController,
                    shouldPresent: shouldPresent)
    }
}
