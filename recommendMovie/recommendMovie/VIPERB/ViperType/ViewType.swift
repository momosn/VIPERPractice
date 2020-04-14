//
//  ViewType.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

/// Describes view component in a VIPER architecture.
protocol ViewType {
    associatedtype P: PresenterType
    /// A presenter
    var presenter: P { get }
    
    // MARK: - refresh View
    func refreshView()
    
}


