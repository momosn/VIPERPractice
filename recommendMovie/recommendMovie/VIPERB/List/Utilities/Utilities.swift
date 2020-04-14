//
//  Utilities.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/26.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit
typealias LoadCompletion = (LoadFeedback) -> ()
typealias Completion = (Bool, LoadFeedback) -> ()

struct LoadFeedback {
    var msg: String = ""
    var needRefresh: Bool = true
    var loadingState: LoadingState = .hidden
    //var blankViewType: BlankViewType = .blankHide
    
//    var blankStyle: ([BlankViewItem]?, BlankViewStyle) = ([], .none)
    
    
    var hasMore = true
    var footerText: String?
}

enum LoadingState {
    case show
    case hidden
}

enum LoadType {
    case pulldown
    case loadMore
}
