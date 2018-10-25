//
//  ViewController.swift
//  AnimationBlock
//
//  Created by 关东升 on 15/1/25.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    var flag = 1
    
    @IBOutlet weak var ball: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func click(sender: AnyObject) {
        
        self.button.alpha = 0.0
        
        var starPath = CGPathCreateMutable()
        CGPathMoveToPoint(starPath, nil, 160.0, 100.0)
        CGPathAddLineToPoint(starPath, nil, 100.0, 280.0)
        CGPathAddLineToPoint(starPath, nil, 260.0, 170.0)
        CGPathAddLineToPoint(starPath, nil, 60.0, 170.0)
        CGPathAddLineToPoint(starPath, nil, 220.0, 280.0)
        CGPathCloseSubpath(starPath)
        
        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 10.0
        animation.path = starPath
        animation.delegate = self
        self.ball.layer.addAnimation(animation!, forKey : "position")
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.button.alpha = 1.0
        })
    }
}

