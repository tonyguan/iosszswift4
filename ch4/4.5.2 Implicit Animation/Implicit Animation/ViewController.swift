//
//  ViewController.swift
//  Implicit Animation
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

    @IBOutlet weak var plane: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plane.layer.opacity = 0.25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func movePlane(sender: AnyObject) {
        let moveTransform = CGAffineTransformMakeTranslation(180, 200)
        self.plane.layer.setAffineTransform(moveTransform)
        self.plane.layer.opacity = 1
    }

}

