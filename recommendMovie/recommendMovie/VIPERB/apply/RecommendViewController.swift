//
//  ViewController.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import UIKit

class RecommendViewController: VTableViewController<RecommendPresenter, UITableView>  {
    
    override init(presenter: P, style: UITableView.Style) {
        super.init(presenter: presenter, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpRefreshHeader()
        self.setUpRefreshFooter()
        pulldown()
    }

    
    override func pulldown() {
        self.presenter.loadList(loadType: LoadType.pulldown, localCompletion: { (loadFeedback) in
            
//            self.view.loading = loadFeedback.loadingState
            self.tableView.reloadData()
        }) { (success, loadFeedback) in
            if !success {
//                self.tableView.mj_footer.endRefreshing()
//                loadFeedback.msg
//                loadFeedback.loadingState
//                loadFeedback.needRefresh
//                loadFeedback.blankViewType
//                loadFeedback.hasMore
//                loadFeedback.footerText
                return
            }
            
//            self.view.loading = loadFeedback.loadingState
//            self.blanView = loadFeedback.bl
            self.tableView.reloadData()
//            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    override func loadMore() {
        self.presenter.loadList(loadType: .loadMore, localCompletion: { (loadFeedback) in
        }) { (success, loadFeedback) in
//            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let item = self.presenter.item(at: indexPath) as? RecommendViewModel else {
            return cell
        }
        
        if let hy_cell = cell as? HYTableViewCell<RecommendViewModel> {
            hy_cell.setViewModel(item)
        }
        return cell
    }
    
    override func registerCellClass() -> [AnyClass] {
        return [RecommendCell.self]
    }
    
}

