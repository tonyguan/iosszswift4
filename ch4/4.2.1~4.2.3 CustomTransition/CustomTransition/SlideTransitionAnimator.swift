//
//  SlideTransitionAnimator.swift
//  PresentationControllers
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

class SlideTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.5;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        var transformedStartFrame =  toVC!.view.frame
        
        let origin = transformedStartFrame.origin
        let width = transformedStartFrame.width
        let height = transformedStartFrame.height
        var transformedEndFrame = CGRectMake(origin.x - width, origin.y, width, height)
        
        transitionContext.containerView().addSubview(fromVC!.view)
        transitionContext.containerView().addSubview(toVC!.view)
        
        UIView.animateWithDuration(1.1, animations: { () -> Void in
                toVC!.view.frame = transformedEndFrame
                toVC!.view.alpha = 0.5
            }, completion: { (finished) -> Void in
                toVC!.view.frame = transformedStartFrame
                toVC!.view.alpha = 1.0
                transitionContext.completeTransition(true)
        })
    }
    
    
}
