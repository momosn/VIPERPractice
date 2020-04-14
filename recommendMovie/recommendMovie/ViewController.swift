//
//  ViewController.swift
//  recommendMovie
//
//  Created by sohu on 2019/12/6.
//  Copyright © 2019 sohu. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let go = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 200, height: 100))
        go.backgroundColor = UIColor.gray
        go.addTarget(self, action: #selector(goNext(button:)), for: .touchUpInside)
        self.view.addSubview(go)
    }
    
    @objc func goNext(button: UIButton) {
        let router = RecommendRouter.init()
        self.navigationController?.pushViewController(router.viewController ?? UIViewController.init(), animated: true)
    }
}
