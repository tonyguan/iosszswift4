//
//  SnapViewController.swift
//  DynamicBehaviorSample
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

class SnapViewController: UIViewController {
    
    var animator : UIDynamicAnimator!
    var snap : UISnapBehavior!
    
    @IBOutlet weak var box: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgTile = UIImage(named:"BackgroundTile")
        self.view.backgroundColor = UIColor(patternImage:bgTile!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleSnapGesture(sender: AnyObject) {
        
        let gesture = sender as! UITapGestureRecognizer
        let point = gesture.locationInView(self.view)
        // 移除甩行为
        if self.snap != nil {
            self.animator.removeBehavior(self.snap)
        }
        self.snap = UISnapBehavior(item: self.box, snapToPoint: point)
        self.animator.addBehavior(self.snap)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.animator = UIDynamicAnimator(referenceView: self.view)
    }
    
}
