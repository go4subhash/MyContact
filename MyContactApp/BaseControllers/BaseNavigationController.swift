//
//  BaseNavigationController.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCurrentNavigationController()
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        updateCurrentNavigationController()
    }

    private func updateCurrentNavigationController() {
        // keep track of current navigation controller
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.currentNavigationController = self
    }
}
