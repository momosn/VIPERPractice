//
//  TestViewModel.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/8/13.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

class RecommendViewModel: ViewModelType {
    
    var model:RecommendModel
    
    init(_ model: RecommendModel) {
        self.model = model
    }
    
    var cellId: String {
        return NSStringFromClass(RecommendCell.self)
    }
    
    var cellSize: CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: 195)
    }
    
    var randomColor:UIColor {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 0.3)
    }
    
    lazy var name: NSAttributedString = {
        return NSAttributedString.init(string: "影片名：\(model.name)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)])
    }()
    
    lazy var brief: NSAttributedString = {
        return NSAttributedString.init(string: "简介：\(model.brief)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular),NSAttributedString.Key.foregroundColor: UIColor.gray])
    }()
    
    lazy var imageUrl:URL? = {
        return URL.init(string: model.image)
    }()
}

class RecommendModel {
    var name = ""
    var image = ""
    var brief = ""
}



//class TestModel {
//
//    let title = "复仇者联盟4终局之战"
//    let image = ""
//
//    let brief = "故事发生在灭霸消灭宇宙一半的生灵并重创复仇者联盟之后，剩余的英雄被迫背水一战，为22部漫威电影写下传奇终章。"
//}
