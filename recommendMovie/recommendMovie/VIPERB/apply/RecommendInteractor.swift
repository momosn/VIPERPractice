//
//  TestInteractor.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/7/10.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation

class RecommendInteractor: InteractorType {
    
    func loadDBData() -> [Section] {
        return DBManager.loadDBData()
    }
    
    func requestData(completion:(_ success: Bool, _ list:[Section],_ msg: String, _ hasMore: Bool) -> ()) {
        NetWorkManager.requestData { (success, list) in
            completion(success, list, "没有更多了", true)
        }
    }
    
    func saveListToDB(list: [Section]) {
        DBManager.saveListToDB(list: list)
    }
    
    func saveModelToDB(model: RecommendViewModel) {
        DBManager.saveModelToDB(model: model)
    }
}


struct DBManager {
    static func saveListToDB(list: [Section]) {
        // save TestViewModel.model
    }
    
    static func saveModelToDB(model: RecommendViewModel) {
        // save TestViewModel.model
    }
    
    static func loadDBData() -> [Section] {
        let viewModel = RecommendViewModel.init(RecommendModel.init())
        let section = Section.init()
        section.items = [viewModel]
        return [section]
    }
}

struct NetWorkManager {
    
    static func requestData(completion:(_ success: Bool, _ list:[Section]) -> ()) {
        let theAvengers_4 = RecommendModel.init()
        theAvengers_4.name = "复仇者联盟4：终局之战"
        theAvengers_4.image = "https://pic8.iqiyipic.com/image/20190715/5f/96/a_100302620_m_601_m1_195_260.jpg"
        theAvengers_4.brief = "故事发生在灭霸消灭宇宙一半的生灵并重创复仇者联盟之后，剩余的英雄被迫背水一战，为22部漫威电影写下传奇终章。"
        let viewModel_4 = RecommendViewModel.init(theAvengers_4)
        
        let theAvengers_3 = RecommendModel.init()
        theAvengers_3.name = "复仇者联盟3：无限战争"
        theAvengers_3.image = "https://img9.doubanio.com/view/photo/l/public/p2517753454.jpg"
        theAvengers_3.brief = "最先与灭霸军团遭遇的雷神索尔一行遭遇惨烈打击，洛基遇害，空间宝石落入灭霸之手。未几，灭霸的先锋部队杀至地球，一番缠斗后掳走奇异博士。为阻止时间宝石落入敌手，斯塔克和蜘蛛侠闯入了敌人的飞船。与此同时，拥有心灵宝石的幻视也遭到外星侵略者的袭击，为此美国队长、黑寡妇等人将其带到瓦坎达王国，向黑豹求助......"
        let viewModel_3 = RecommendViewModel.init(theAvengers_3)
        
        let theAvengers_2 = RecommendModel.init()
        theAvengers_2.name = "复仇者联盟2：奥创纪元"
        theAvengers_2.image = "https://img3.doubanio.com/view/photo/l/public/p2237747953.jpg"
        theAvengers_2.brief = "托尼·斯塔克试图重启一个已经废弃的维和项目，不料该项目却成为危机导火索。世上最强大的超级英雄——钢铁侠、美国队长、雷神、绿巨人、黑寡妇和鹰眼 ，不得不接受终极考验，拯救危在旦夕的地球。"
        let viewModel_2 = RecommendViewModel.init(theAvengers_2)
        let section = Section.init()
        section.items = [viewModel_4, viewModel_3, viewModel_2]
        
        completion(true, [section])
    }
}
