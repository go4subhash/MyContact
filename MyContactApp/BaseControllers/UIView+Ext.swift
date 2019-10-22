//
//  UIView+Ext.swift
//  MyContactApp
//
//  Created by Subhash on 20/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String(describing: self)
        return (Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)?.first as? T) ?? T()
    }

    class func loadCommanNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String(describing: self)
        return (Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)?.first as? T) ?? T()
    }

    class func loadNib() -> Self {
        return loadNib(self)
    }

    class func loadCommanNib() -> Self {
        return loadCommanNib(self)
    }

    func loadViewFromNib() -> UIView {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view ?? UIView()
    }

    @discardableResult
    func show(placholder type: PlaceHolderType,
              view: UIView) -> UIView? {
        switch type {
        case .noDataAvailable:
            return addView(view: view)
        default:
            break
        }
        return nil
    }

    fileprivate func addView(view controllerView: UIView) -> UIView {
        let view = EmptyView.loadNib()
        view.frame = CGRect(x: 0,
                            y: 0,
                            width: controllerView.frame.width,
                            height: controllerView.frame.height)
        return view
    }
}
