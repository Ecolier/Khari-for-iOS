//
//  UserHeader.swift
//  Khari
//
//  Created by Evan Gruère on 29/01/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryHeaderView: UIView {
    
    let touchIndicator: TouchIndicatorView
    let userPicture = UserPicture()
    let usernameLabel = UILabel()
    
    private let topMargin: CGFloat = 6
    private let bottomMargin: CGFloat = 6
    private let touchIndicatorWidth: CGFloat = 42
    private let touchIndicatorHeight: CGFloat = 6
    private let touchIndicatorBottomMargin: CGFloat = 9
    private let userPictureSize: CGFloat = 72
    private let usernameLabelTopMargin: CGFloat = 6
    
    init() {
        self.touchIndicator = TouchIndicatorView(frame: CGRect(origin: .zero,
                                                               size: CGSize(width: self.touchIndicatorWidth,
                                                                            height: self.touchIndicatorHeight)))
        super.init(frame: .zero)
        self.addSubview(self.touchIndicator)
        self.addSubview(self.userPicture)
        self.addSubview(self.usernameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.touchIndicator.frame = CGRect(x: self.frame.midX - self.touchIndicatorWidth / 2,
                                           y: self.topMargin,
                                           width: self.touchIndicatorWidth, height: self.touchIndicatorHeight)
        
        self.userPicture.frame = CGRect(x: self.frame.midX - self.userPictureSize / 2,
                                        y: self.touchIndicator.frame.maxY + touchIndicatorBottomMargin,
                                        width: self.userPictureSize, height: self.userPictureSize)
        
        self.usernameLabel.frame = CGRect(x: self.frame.midX - self.usernameLabel.intrinsicContentSize.width / 2,
                                          y: self.userPicture.frame.maxY + usernameLabelTopMargin,
                                          width: self.usernameLabel.intrinsicContentSize.width,
                                          height: self.usernameLabel.intrinsicContentSize.height)
        
        self.frame.size.height = self.usernameLabel.frame.maxY + self.bottomMargin
        
    }
    
}
