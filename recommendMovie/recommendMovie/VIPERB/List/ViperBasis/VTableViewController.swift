//
//  ViperViewController.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

/// Viper view controller base class.
typealias ListPresenterType = PresenterType & ListDataProtocol

class VTableViewController<P: ListPresenterType, T: UITableView>: UIViewController, ViewType, ListViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    let presenter: P
    
    init(presenter: P, style: UITableView.Style) {
        self.presenter = presenter
        self.tableView = T.init(frame: CGRect.zero, style: style)
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
    }
    
    // MARK: -
    // MARK: - Invalid initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hy_setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.viewWillBecomeActive()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        presenter.viewDidBecomeInactive()
    }
    
    
    // MARK: -
    // MARK: - tableView
    var tableView: T
    private func hy_setUpUI() {
        
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.hy_registeCell()
        self.hy_registeHeaderAndFooterView()
    }
    
    // MARK: -
    // MARK: - tableView data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfItemsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = self.presenter.item(at: indexPath)?.cellId ?? ""
        
        #if DEBUG
        assert(self.presenter.item(at: indexPath) != nil, "There is no item")
        assert(cellId.isEmpty != true, "Item don't has cellId")
        #else
        if cellId.isEmpty {
            return UITableViewCell.init()
        }
        #endif
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell.init()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        #endif
        return self.presenter.section(in: section)?.headerTitle ?? ""
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        #endif
        return self.presenter.section(in: section)?.footerTitle ?? ""
    }
    
    // MARK: -
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        #if DEBUG
        assert(self.presenter.item(at: indexPath) != nil, "There is no item")
        return self.presenter.item(at: indexPath)?.cellSize.height ?? 0
        #else
        
        guard let cellId = self.presenter.item(at: indexPath)?.cellId else {
            return 0
        }
        
        if cellId.isEmpty {
            return 0
        }
        
        // No found cell
        let registeCells = registerCellClass() + registerCellNib()
        guard (registeCells.contains { NSStringFromClass($0) == cellId}) else {
            return 0
        }
        return self.presenter.item(at: indexPath)?.cellSize.height ?? 0
        #endif
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        return self.presenter.section(in: section)?.headerSize.height ?? 0
        #else
        // There is no headerId
        guard let headerId = self.presenter.section(in: section)?.headerId else {
            return 0
        }
        if headerId.isEmpty {
            return 0
        }
        
        // No found header
        let registeHeaders = registerHeaderClass() + registerHeaderNib()
        guard (registeHeaders.contains { NSStringFromClass($0) == headerId}) else {
            return 0
        }
        return self.presenter.section(in: section)?.headerSize.height ?? 0
        #endif
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        return self.presenter.section(in: section)?.footerSize.height ?? 0
        #else
        guard let footerId = self.presenter.section(in: section)?.footerId else {
            return 0
        }
        if footerId.isEmpty {
            return 0
        }
        
        // No found footer
        let registeFooters = registerFooterClass() + registerFooterNib()
        guard (registeFooters.contains { NSStringFromClass($0) == footerId}) else {
            return 0
        }
        return self.presenter.section(in: section)?.footerSize.height ?? 0
        #endif
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        #endif
        let headerId = self.presenter.section(in: section)?.headerId ?? ""
        
        // No found header
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) else {
            return nil
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        #endif
        let footerId = self.presenter.section(in: section)?.footerId ?? ""
        
        // No found header
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) else {
            return nil
        }
        
        return header
    }
    
    // MARK: -
    // MARK: - viewType
    func refreshView() {
        self.tableView.reloadData()
    }
    
    // MARK: -
    // MARK: - ListViewProtocol
    func pulldown() {}
    func loadMore() {}
    
    func setUpRefreshHeader() {
//        self.tableView.mj_header = PullDownHeader.init(refreshingBlock: {
//            self.pulldown()
//        })
    }
    
    func setUpRefreshFooter() {
//        self.tableView.mj_footer = LoadMoreFooter.init(refreshingBlock: {
//            self.loadMore()
//        })
    }
    
    func registerCellClass() -> [AnyClass] {
        return []
    }
    
    func registerCellNib() -> [AnyClass] {
        return []
    }
    
    func registerHeaderClass() -> [AnyClass] {
        return []
    }
    
    func registerHeaderNib() -> [AnyClass] {
        return []
    }
    
    func registerFooterClass() -> [AnyClass] {
        return []
    }
    
    func registerFooterNib() -> [AnyClass] {
        return []
    }
    
    // MARK: - private
    private func hy_registeCell() {
        for cellClass in self.registerCellClass() {
            self.tableView.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
        }
        
        for cellClass in self.registerCellNib() {
            self.tableView.register(UINib.init(nibName: NSStringFromClass(cellClass), bundle: nil), forCellReuseIdentifier: NSStringFromClass(cellClass))
        }
    }
    
    private func hy_registeHeaderAndFooterView() {
        
        let headerAndFooterClass = self.registerHeaderClass() + self.registerFooterClass()
        for viewClass in headerAndFooterClass {
            self.tableView.register(viewClass, forHeaderFooterViewReuseIdentifier: NSStringFromClass(viewClass))
        }
        
        let headerAndFooterNib = self.registerHeaderNib() + self.registerFooterNib()
        for viewClass in headerAndFooterNib {
            self.tableView.register(UINib.init(nibName: NSStringFromClass(viewClass), bundle: nil), forHeaderFooterViewReuseIdentifier: NSStringFromClass(viewClass))
        }
    }
}

