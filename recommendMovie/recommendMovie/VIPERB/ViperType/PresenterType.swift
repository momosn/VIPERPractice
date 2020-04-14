//
//  PresenterType.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

/// Describes presenter component in a VIPER architecture.
protocol PresenterType: class {
    
    associatedtype I: InteractorType
    /// A presenter
    var interactor: I { get }
    
//    // MARK: -
//    // MARK: - View life cycle
//    /// Informs presenter that the view will become active.
//    func viewWillBecomeActive()
//
//    /// Informs presenter that the view just became inactive.
//    func viewDidBecomeInactive()
}

///// Optional methods related to view state.
//extension PresenterType {
//    // MARK: -
//    // MARK: - View life cycle
//    func viewWillBecomeActive() {}
//    func viewDidBecomeInactive() {}
//
//}


