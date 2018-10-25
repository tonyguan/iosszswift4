//
//  ViewController.swift
//  TransitionAnimator
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

enum HUTransitionType {
    case Transition6Style
    case TransitionGhost
    case TransitionVerticalLines
    case TransitionHorizontalLines
}

class ViewController: UITableViewController,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate {
    
    var transitionType : HUTransitionType = .Transition6Style

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TransitionGhost" {
            self.transitionType = .TransitionGhost
        } else if segue.identifier == "TransitionVerticalLines" {
            self.transitionType = .TransitionVerticalLines
        }  else if segue.identifier == "TransitionHorizontalLines" {
            self.transitionType = .TransitionHorizontalLines
        }  else if segue.identifier == "Transition6Style" {
            self.transitionType = .Transition6Style
        } else {
            var destinationViewController = segue.destinationViewController as! UIViewController
            destinationViewController.transitioningDelegate = self
        }
    }
    
    // MARK: --实现UINavigationControllerDelegate协议
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var animator : HUTransitionAnimator!
        
        switch self.transitionType {
        case .TransitionGhost:
            animator = HUTransitionGhostAnimator()
            break;
        case .TransitionVerticalLines:
            animator = HUTransitionVerticalLinesAnimator()
            break;
        case .TransitionHorizontalLines:
            animator = HUTransitionHorizontalLinesAnimator()
            break;
        default:
            animator = HUTransitionAnimator()
            break;
        }
        animator.presenting = (operation == UINavigationControllerOperation.Pop) ? false : true
        return animator
    }
    
    // MARK: --实现UIViewControllerTransitioningDelegate协议
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HUTransitionVerticalLinesAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HUTransitionHorizontalLinesAnimator()
    }

}

