//
//  UIStoryboard+Ext.swift
//  MyContactApp
//
//  Created by Subhash on 19/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }


extension UIStoryboard {

    // MARK: - Convenience Initializers
    convenience init(storyboard: Storyboard,
                     bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue,
                  bundle: bundle)
    }

    // MARK: - Class Functions
    class func storyboard(_ storyboard: Storyboard,
                          bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue,
                            bundle: bundle)
    }

    // MARK: - View Controller Instantiation from Generics
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
        else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}
