//
//  ViewController.swift
//  ParallaxEffect
//
//  Created by 关东升 on 15/1/27.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cowboy: UIImageView!
    @IBOutlet weak var tree: UIImageView!
    @IBOutlet weak var mountain: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置山在X轴的偏移范围-50.0~50.0
        var mountainEffectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        mountainEffectX.maximumRelativeValue = 50.0
        mountainEffectX.minimumRelativeValue = -50.0
        self.mountain.addMotionEffect(mountainEffectX)

        //设置树在X轴的偏移范围-100.0~100.0
        var treeEffectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        treeEffectX.maximumRelativeValue = 100.0
        treeEffectX.minimumRelativeValue = -100.0
        self.tree.addMotionEffect(treeEffectX)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

