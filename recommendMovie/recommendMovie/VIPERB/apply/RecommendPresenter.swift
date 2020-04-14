//
//  TestPresenter.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/8/13.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

class RecommendPresenter: ListPresenterType {

    var viewModels: [Section] = []
    let interactor = RecommendInteractor.init()

    func loadList(loadType: LoadType, localCompletion: LoadCompletion, completion: @escaping Completion) {

        //  没有展示数据，先使用本地数据
        if (loadType == .pulldown && self.viewModels.count == 0) {
            
            self.viewModels = interactor.loadDBData()
            
            var loadFeedback = LoadFeedback.init()
            if self.viewModels.count > 0 {
                loadFeedback.loadingState = .show
            }
            localCompletion(loadFeedback)
        }
        
        // 请求数据
        self.interactor.requestData { (success, list, msg, hasMore) in
            // 请求未成功
            if !success {
                var loadFeedback = LoadFeedback.init()
                if self.viewModels.count <= 0 {
                    loadFeedback.msg = msg
                }
                completion(false, loadFeedback)
                return
            }
            
            // 请求成功
            if loadType == .loadMore {
                self.viewModels += list
            } else {
                self.viewModels = list                
            }
            
            var loadFeedback = LoadFeedback.init()
            loadFeedback.hasMore = hasMore
            loadFeedback.footerText = "ddd"
            if self.viewModels.count <= 0 {
                loadFeedback.msg = msg
//                loadFeedback.blankViewType = .blank_4_1(sDes: "")
            }
            completion(true, loadFeedback)

        }
    }
    
}
