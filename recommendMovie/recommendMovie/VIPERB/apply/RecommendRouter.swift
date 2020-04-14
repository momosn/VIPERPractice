//
//  TestRouter.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/8/14.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class RecommendRouter:NSObject, RouterType {
    var viewController: UIViewController?
    
    override init() {
        let presenter = RecommendPresenter.init()
        let viewController = RecommendViewController.init(presenter: presenter, style: UITableView.Style.plain)
        self.viewController = viewController
        super.init()
    }
}

