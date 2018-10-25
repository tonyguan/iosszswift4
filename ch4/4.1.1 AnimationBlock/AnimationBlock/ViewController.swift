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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func click(sender: AnyObject) {
        
        UIView.animateWithDuration(1.5) { () -> Void in
            var frame = self.ball.frame
            frame.origin.y += CGFloat(100 * self.flag)
            self.flag *= -1 //取反
            self.ball.frame = frame
        }
        
    }

}

