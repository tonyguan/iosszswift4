//
//  CollisionViewController.swift
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

class CollisionViewController: UIViewController {

    @IBOutlet weak var ballImageView: UIImageView!
    
    var animator    :   UIDynamicAnimator!
    var gravity     :  UIGravityBehavior!
    var collision   :  UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.animator = UIDynamicAnimator(referenceView: self.view)
        //重力行为
        self.gravity = UIGravityBehavior(items: [self.ballImageView])
        //设置重力的方向
        let gravityDirection : CGVector = CGVectorMake(0.0, 0.1)
        self.gravity!.gravityDirection = gravityDirection
        
        self.animator.addBehavior(self.gravity)
        
        //碰撞行为
        self.collision = UICollisionBehavior(items: [self.ballImageView])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(self.collision)
    }

}
