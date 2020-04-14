//
//  VCollectionViewController.swift
//  sohuhy
//
//  Created by mojue on 2019/7/22.
//  Copyright © 2019 sohu. All rights reserved.
//

import Foundation
import UIKit

/// Viper view controller base class.
class VCollectionViewController<P: PresenterType & ListDataProtocol, T: UICollectionView>: UIViewController, ViewType, ListViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let presenter: P
    private let defaultCellId = "defaultCellId"
    private let supplementaryViewId = "supplementaryViewId"
    
    init(presenter: P, layout: UICollectionViewLayout) {
        self.presenter = presenter
        self.collectionView = T.init(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: -
    // MARK: - Invalid initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        hy_setUpUI()
    }
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        presenter.viewWillBecomeActive()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        presenter.viewDidBecomeInactive()
    }
    
    
    // MARK: -
    // MARK: - tableView
    var collectionView: T
    func hy_setUpUI() {
        self.view.addSubview(self.collectionView)
//        self.collectionView.backgroundColor = UIColor.blk_12()
        self.collectionView.frame = self.view.bounds
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        hy_registeCell()
        hy_registeHeaderView()
        hy_registeFooterView()
    }
    
    // MARK: -
    // MARK: - collectionView data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfItemsInSection(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = self.presenter.item(at: indexPath)?.cellId ?? ""
        
        #if DEBUG
        assert(self.presenter.item(at: indexPath) != nil, "There is no item")
        assert(cellId.isEmpty != true, "Item don't has cellId")
        #else
        if cellId.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellId, for: indexPath)
        }
        #endif
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        #if DEBUG
        assert(self.presenter.section(in: indexPath.section) != nil, "There is no section")
        #endif
        var viewId = ""
        if kind == UICollectionView.elementKindSectionHeader {
            viewId = self.presenter.section(in: indexPath.section)?.headerId ?? ""
        } else if kind == UICollectionView.elementKindSectionFooter {
            viewId = self.presenter.section(in: indexPath.section)?.footerId ?? ""
        }
        
        if viewId.isEmpty {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: supplementaryViewId, for: indexPath)
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewId, for: indexPath)
        
        return view
    }
    
    // MARK: -
    // MARK: - scrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    // MARK: -
    // MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

    
    // MARK: -
    // MARK: - collectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        #if DEBUG
        assert(self.presenter.item(at: indexPath) != nil, "There is no item")
        return self.presenter.item(at: indexPath)?.cellSize ?? CGSize.zero
        #else
        
        guard let cellId = self.presenter.item(at: indexPath)?.cellId else {
            return CGSize.zero
        }
        if cellId.isEmpty {
            return CGSize.zero
        }
        
        // No found cell
        let registeCells = registerCellClass() + registerCellNib()
        guard (registeCells.contains { NSStringFromClass($0) == cellId}) else {
            return CGSize.zero
        }
        
        return self.presenter.item(at: indexPath)?.cellSize ?? CGSize.zero
        #endif
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        return self.presenter.section(in: section)?.headerSize ?? CGSize.zero
        #else
        guard let headerId = self.presenter.section(in: section)?.headerId else {
            return CGSize.zero
        }
        if headerId.isEmpty {
            return CGSize.zero
        }

        // No found cell
        let registeHeaders = registerHeaderClass() + registerHeaderNib()
        guard (registeHeaders.contains { NSStringFromClass($0) == headerId}) else {
            return CGSize.zero
        }
        return self.presenter.section(in: section)?.headerSize ?? CGSize.zero
        #endif
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        #if DEBUG
        assert(self.presenter.section(in: section) != nil, "There is no section")
        return self.presenter.section(in: section)?.footerSize ?? CGSize.zero
        #else
        guard let footerId = self.presenter.section(in: section)?.footerId else {
            return CGSize.zero
        }
        if footerId.isEmpty {
            return CGSize.zero
        }

        // No found cell
        let registeFooters = registerFooterClass() + registerFooterNib()
        guard (registeFooters.contains { NSStringFromClass($0) == footerId}) else {
            return CGSize.zero
        }
        return self.presenter.section(in: section)?.footerSize ?? CGSize.zero
        #endif
    }
    
    // MARK: -
    // MARK: - viewType
    func refreshView() {
        self.collectionView.reloadData()
    }
    
    // MARK: -
    // MARK: - ListViewProtocol
    func pulldown() {}
    func loadMore() {}
    
    func setUpRefreshHeader() {
//        self.collectionView.mj_header = PullDownHeader.init(refreshingBlock: {
//            self.pulldown()
//        })
    }
    
    func setUpRefreshFooter() {
//        self.collectionView.mj_footer = LoadMoreFooter.init(refreshingBlock: {
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
            self.collectionView.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
        }
        
        for cellClass in self.registerCellNib() {
            self.collectionView.register(UINib.init(nibName: NSStringFromClass(cellClass), bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(cellClass))
        }
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: defaultCellId)
    }
    
    private func hy_registeHeaderView() {
        for viewClass in self.registerHeaderClass() {
            self.collectionView.register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(viewClass))
        }
        
        for viewClass in self.registerHeaderNib() {
            self.collectionView.register(UINib.init(nibName: NSStringFromClass(viewClass), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(viewClass))
        }
        
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplementaryViewId)
    }
    private func hy_registeFooterView() {
        for viewClass in self.registerFooterClass() {
            self.collectionView.register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NSStringFromClass(viewClass))
        }
        
        for viewClass in self.registerFooterNib() {
            self.collectionView.register(UINib.init(nibName: NSStringFromClass(viewClass), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NSStringFromClass(viewClass))
        }
        
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: supplementaryViewId)
    }
}
