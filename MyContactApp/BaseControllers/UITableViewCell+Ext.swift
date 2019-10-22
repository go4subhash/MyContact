//
//  UITableViewCell+Ext.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

typealias CellRegisterProtocol = NibLoadableView & ReusableView

extension UITableViewCell: CellRegisterProtocol {}


