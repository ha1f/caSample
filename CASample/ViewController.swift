//
//  ViewController.swift
//  CASample
//
//  Created by ST20591 on 2016/07/13.
//  Copyright © 2016年 ha1f. All rights reserved.
//

import UIKit

// http://niwatako.hatenablog.jp/entry/2016/03/02/170226
// mask, clipは遅い
// layer.contentsでCGImageをセットできる？

class ShadowBox: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let myLayer = self.layer
        myLayer.shadowColor = UIColor.blackColor().CGColor
        myLayer.shadowOpacity = 0.75
        myLayer.shadowOffset = CGSizeMake(5, 10)
        myLayer.shadowRadius = 10
        
        // パフォーマンスに重要
        let myShadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        myLayer.shadowPath = myShadowPath.CGPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate() {
        
        // contentsに大してアニメーションすればクロスフェードできる
        let anim = CABasicAnimation(keyPath: "position.x")
        anim.duration = 2.0
        anim.fromValue = self.layer.position.x
        anim.toValue = self.layer.position.x + 200
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.repeatCount = .infinity
        self.layer.addAnimation(anim, forKey: "moveAnimation")
        
        // keyFrameAnimationでもほぼ同様
        // keyPathは変えたい奴、pathが軌道、
        // delegateをanimationにセットできる -> animationDidStop
        
        // CATransaction?
    }
}

class Box3D: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -500
        transform = CATransform3DRotate(transform, CGFloat(45.0 * M_PI / 180), 0, 1, 0)
        self.layer.transform = transform
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v = ShadowBox(frame: CGRectMake(50, 50, 100, 100))
        v.backgroundColor = UIColor.redColor()
        self.view.addSubview(v)
        
        let v2 = Box3D(frame: CGRectMake(50, 200, 100, 100))
        v2.backgroundColor = UIColor.blueColor()
        self.view.addSubview(v2)
        
        v.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

