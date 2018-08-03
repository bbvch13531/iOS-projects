//
//  KYScrollView.swift
//  CustomScrollView
//
//  Created by KyungYoung Heo on 2018. 8. 2..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit

class KYScrollView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panView(with:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func panView(with gestureRecognizer: UIPanGestureRecognizer){
        let translation = gestureRecognizer.translation(in: self)
        
        self.bounds.origin.y = self.bounds.origin.y - translation.y
        gestureRecognizer.setTranslation(CGPoint.zero, in: self)
    }
}
