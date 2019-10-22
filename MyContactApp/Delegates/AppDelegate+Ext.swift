//
//  AppDelegate+Ext.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {

    func initialSetUp() {
        IQKeyboardManager.shared.enable = true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Register For Remote Notification \(error.localizedDescription)")
    }
}
