//
//  UserHeader.swift
//  Khari
//
//  Created by Evan Gruère on 29/01/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DiscoveryHeaderView: UIView {
    
    var isCondensed: Bool = false
    
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
    
    private let condensedTouchIndicatorBottomMargin: CGFloat = 18
    private let condensedPictureSize: CGFloat = 36
    private let condensedPictureLeftMargin: CGFloat = 9
    private let condensedUsernameLabelLeftMargin: CGFloat = 6
    
    init() {
        self.touchIndicator = TouchIndicatorView(frame: CGRect(origin: .zero,
                                                               size: CGSize(width: self.touchIndicatorWidth,
                                                                            height: self.touchIndicatorHeight)))
        
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.08
        self.backgroundColor = .white
        
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
        
        self.usernameLabel.frame.size = CGSize(width: self.usernameLabel.intrinsicContentSize.width,
                                               height: self.usernameLabel.intrinsicContentSize.height)
        
        if self.isCondensed {
            
            self.userPicture.frame = CGRect(x: self.condensedPictureLeftMargin,
                                            y: self.condensedTouchIndicatorBottomMargin,
                                            width: self.condensedPictureSize,
                                            height: self.condensedPictureSize)
            
            self.usernameLabel.frame.origin = CGPoint(
                x: self.userPicture.frame.maxX + self.condensedUsernameLabelLeftMargin,
                y: self.userPicture.frame.midY - self.usernameLabel.bounds.height / 2)
            
        } else {
            
            self.userPicture.frame = CGRect(x: self.frame.midX - self.userPictureSize / 2,
                                            y: self.touchIndicator.frame.maxY + touchIndicatorBottomMargin,
                                            width: self.userPictureSize, height: self.userPictureSize)
            
            self.usernameLabel.frame.origin = CGPoint(
                x: self.frame.midX - self.usernameLabel.intrinsicContentSize.width / 2,
                y: self.userPicture.frame.maxY + usernameLabelTopMargin)
            
        }
        
    }
    
}
