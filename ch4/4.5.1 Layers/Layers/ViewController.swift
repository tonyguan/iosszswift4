//
//  ViewController.swift
//  Layers
//
//  Created by 关东升 on 15/3/25.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {
    
    var ballLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "ball.png")
        
        self.ballLayer.contents = image?.CGImage
        self.ballLayer.contentsGravity = kCAGravityResizeAspect
        self.ballLayer.bounds = CGRectMake(0.0, 0.0, 125.0, 125.0)
        self.ballLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds),
                                                CGRectGetMidY(self.view.bounds))
        
        self.view.layer.addSublayer(self.ballLayer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

