//
//  ViewController.swift
//  Animation Transition
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
    
    @IBAction func doUIViewAnimation(sender: AnyObject) {
        
        let theButton = sender as! UIButton
        NSLog("tag = %i", theButton.tag)
        
        switch theButton.tag {
        case 1:
            UIView.transitionWithView(self.view , duration: 3.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
                    NSLog("动画开始...")
                }, completion: { (finished) -> Void in
                    NSLog("动画完成.")
            })
        case 2:
            UIView.transitionWithView(self.view , duration: 3.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                    NSLog("动画开始...")
                }, completion: { (finished) -> Void in
                    NSLog("动画完成.")
            })
            
         case 3:
            UIView.transitionWithView(self.view , duration: 3.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
                    NSLog("动画开始...")
                }, completion: { (finished) -> Void in
                    NSLog("动画完成.")
            })
        default:
            UIView.transitionWithView(self.view , duration: 3.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.TransitionCurlDown, animations: { () -> Void in
                    NSLog("动画开始...")
                }, completion: { (finished) -> Void in
                    NSLog("动画完成.")
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

