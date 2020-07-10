//
//  CollapsableView.swift
//  Khari
//
//  Created by Evan Gruère on 22/06/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class CollapsableView: UIView {
    
    var fullY: CGFloat = 0
    var collapsedY: CGFloat = 0
    var breakY: CGFloat = 0
    
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
            
        case .changed:
            
            let translation = recognizer.translation(in: self)
            if translation.y < 0 && self.frame.origin.y <= self.fullY {
                self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x,
                                y: self.fullY),
                size: self.frame.size)
                break
            }
            self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x,
                                                y: self.frame.origin.y + translation.y),
                                size: self.frame.size)
            recognizer.setTranslation(.zero, in: self)
            
        case .ended:
            
            let velocity = recognizer.velocity(in: self)
            if self.frame.origin.y < self.breakY / 2 || velocity.y < -500 {
                UIView.animate(withDuration: 0.2) {
                    self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x,
                                                        y: self.fullY),
                                        size: self.frame.size)
                }
            }
            if self.frame.origin.y > self.breakY / 2 || velocity.y > 500 {
                UIView.animate(withDuration: 0.2) {
                    self.frame = CGRect(origin: CGPoint(x: self.frame.origin.x,
                                                        y: self.collapsedY),
                                        size: self.frame.size)
                }
            }
            
        default:
            break
        }
    }
    
}

