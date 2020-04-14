//
//  RouterTyper.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

/// Describes router component in a VIPER architecture.
protocol RouterType: class {
    /// The reference to the view which the router should use
    /// as a starting point for navigation. Injected by the builder.
    var viewController: UIViewController? { get set }
}
