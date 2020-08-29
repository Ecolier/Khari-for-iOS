//
//  CollapsableView.swift
//  Khari
//
//  Created by Evan Gruère on 22/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class CollapsableView: UIView {
    
    var onPanDown: () -> Void = { }
    var onPanUp: () -> Void = { }
    
    var minHeight: CGFloat = 0
    var containerFrame: CGRect = .zero
    var isCollapsed: Bool = true
    
    var isInteracting: Bool = false
    var isPanningDown: Bool = false
    
    private var offsetY: CGFloat = 0
    
    init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    private func initialize() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panView))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func panView(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
            
        case .began:
            self.isInteracting = true
            
        case .changed:
            
            let translation = recognizer.translation(in: self)
            self.isPanningDown = translation.y > 0
            
            self.isPanningDown ? self.onPanDown() : self.onPanUp()
            
            if !self.isPanningDown && self.frame.origin.y <= self.containerFrame.minY {
                self.isInteracting = false
                return
            }
            
            self.isInteracting = true
            
            self.offsetY = translation.y
            self.setNeedsLayout()
            
            recognizer.setTranslation(.zero, in: self)
            
        case .ended:
            
            self.isInteracting = false
            
            let velocity = recognizer.velocity(in: self)
            if self.frame.origin.y < self.containerFrame.midY || velocity.y < -500 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.frame.origin.y = self.containerFrame.minY
                    self.isCollapsed = false
                })
            }
            if self.frame.origin.y > self.containerFrame.midY || velocity.y > 500 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.frame.origin.y = self.containerFrame.maxY - self.minHeight
                    self.isCollapsed = true
                })
            }
            
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.isInteracting {
            self.frame.origin.y += self.offsetY
        } else {
            if self.isCollapsed {
                self.frame.origin.y = self.containerFrame.maxY - self.minHeight
            } else {
                self.frame.origin.y = self.containerFrame.minY
            }
        }
        
    }
}

