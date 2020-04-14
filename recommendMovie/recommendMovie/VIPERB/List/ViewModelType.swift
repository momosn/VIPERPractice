//
//  EntityType.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/6/25.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit

/// Describes view model component in a VIPER architecture.
protocol ViewModelType {
    var cellId: String { get }
    
    var cellSize: CGSize { get }
}

protocol SectionType {
    var items: [ViewModelType] { get set }
    
    var headerSize: CGSize { get }
    var footerSize: CGSize { get }
    
    var headerId: String { get }
    var footerId: String { get }
    
    var headerTitle: String { get }
    var footerTitle: String { get }
}

class Section: SectionType {
    var items: [ViewModelType] = []
    
    var headerSize: CGSize = CGSize.zero
    var footerSize: CGSize = CGSize.zero
    
    var headerId: String = ""
    var footerId: String = ""
    
    var headerTitle: String = ""
    var footerTitle: String = ""
    
}
