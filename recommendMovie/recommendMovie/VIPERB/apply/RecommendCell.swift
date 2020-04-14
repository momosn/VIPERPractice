//
//  TestCell.swift
//  viperSwiftDemo
//
//  Created by mojue on 2019/8/13.
//  Copyright © 2019 hy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class RecommendCell: HYTableViewCell<RecommendViewModel> {
    
    lazy var titleLabel = UILabel.init()
    lazy var briefLabel = UILabel.init()
    lazy var pic = UIImageView.init()
    override func setViewModel(_ viewModel: RecommendViewModel) {
        super.setViewModel(viewModel)
        self.backgroundColor = UIColor.white
        
        self.titleLabel.attributedText = viewModel.name
        self.briefLabel.attributedText = viewModel.brief
        self.pic.sd_setImage(with: viewModel.imageUrl) { (image, error, cacheType, url) in
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margin: CGFloat = 10
        let imageTop: CGFloat = 50
        let imageHeight: CGFloat = 127
        let imageWidth: CGFloat = 90
        self.titleLabel.frame = CGRect.init(x: margin, y: margin * 2, width: self.bounds.width, height: 15)
        self.contentView.addSubview(self.titleLabel)
        
        self.briefLabel.frame =  CGRect.init(x: imageWidth + margin * 2, y: imageTop, width: self.bounds.width - imageWidth - margin * 3, height: imageHeight)
        self.contentView.addSubview(self.briefLabel)
        self.briefLabel.numberOfLines = 0
        
        self.pic.frame = CGRect.init(x: margin, y: imageTop, width: imageWidth, height: imageHeight)
        self.contentView.addSubview(self.pic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
