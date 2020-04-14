//
//  ListViewProtocol.swift
//  sohuhy
//
//  Created by mojue on 2019/8/15.
//  Copyright © 2019 sohu. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewProtocol {
    
    // MARK: - load
    func pulldown()
    func loadMore()
    
    // MARK: - register
    func registerCellClass() -> [AnyClass]
    func registerCellNib() -> [AnyClass]
    func registerHeaderClass() -> [AnyClass]
    func registerHeaderNib() -> [AnyClass]
    func registerFooterClass() -> [AnyClass]
    func registerFooterNib() -> [AnyClass]
    
    // MARK: - refresh
    func setUpRefreshHeader()
    func setUpRefreshFooter()
}

class HYTableViewCell<T>: UITableViewCell {
    
    var viewModel: T?
    func setViewModel(_ viewModel: T) {
        self.viewModel = viewModel
    }
}

class HYCollectionViewCell<T>: UICollectionViewCell {
    
    var viewModel: T?
    func setViewModel(_ viewModel: T) {
        self.viewModel = viewModel
    }
}
