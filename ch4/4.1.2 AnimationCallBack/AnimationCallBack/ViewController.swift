//
//  ViewController.swift
//  AnimationCallBack
//
//  Created by 关东升 on 15/1/26.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ball: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    
    var flag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func click(sender: AnyObject) {
        self.button.alpha = 0.0
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            var frame = self.ball.frame
            frame.origin.y += CGFloat(100 * self.flag)
            self.flag *= -1 //取反
            self.ball.frame = frame
            
        }) { (finished) -> Void in
            NSLog("动画结束了。")
            self.viewAnimationDone()
        }
    }
    
    func viewAnimationDone() {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.button.alpha = 1.0
        })
    }
}

