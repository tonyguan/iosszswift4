//
//  AttachmentViewController.swift
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

class AttachmentViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var attachmentPoint: UIImageView!
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var barrier: UIImageView!
    
    var animator : UIDynamicAnimator!
    var attach :  UIAttachmentBehavior!
    var gravity :  UIGravityBehavior!
    var collision :  UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgTile = UIImage(named:"BackgroundTile")
        self.view.backgroundColor = UIColor(patternImage:bgTile!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        //重力行为
        self.gravity = UIGravityBehavior(items: [self.box])
        self.animator.addBehavior(self.gravity)
        
        //碰撞行为
        self.collision = UICollisionBehavior(items: [self.box])
        
        let width = self.barrier.frame.size.width
        let origin = self.barrier.frame.origin
        self.collision.addBoundaryWithIdentifier("barrier",
                    fromPoint : origin,
                    toPoint : CGPointMake(origin.x + width, origin.y))

        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.collisionDelegate = self
        
        self.animator.addBehavior(self.collision)
        
        var itemBehaviour = UIDynamicItemBehavior(items: [self.box])
        itemBehaviour.elasticity = 0.5
        self.animator.addBehavior(itemBehaviour)
    
    }
    
    // MARK: --实现UICollisionBehaviorDelegate协议
    func collisionBehavior(behavior: UICollisionBehavior,
        beganContactForItem item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
            
        //设置吸附行为
        self.attach = UIAttachmentBehavior(item: self.attachmentPoint, attachedToItem: self.box)
        self.animator.addBehavior(self.attach)
    }

}
