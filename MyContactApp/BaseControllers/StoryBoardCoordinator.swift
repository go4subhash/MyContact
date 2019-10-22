//
//  StoryBoardCoordinator.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit



class StoryboardCoordinator {

// MARK: - Private Init
private init() { }
    
    class func loadContactDetailViewController() -> ContactDetailVC? {
        let storyboard = UIStoryboard(storyboard: .contactDetail)
        let viewController: ContactDetailVC = storyboard.instantiateViewController()
        return viewController
    }
}
