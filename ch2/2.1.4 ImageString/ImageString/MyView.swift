//
//  MyView.swift
//  ImageString
//
//  Created by 关东升 on 15/1/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class MyView: UIView {

    override func drawRect(rect: CGRect) {
        
        let imagePath = NSBundle.mainBundle().pathForResource("dog", ofType: "png")
        
        let myImageObj = UIImage(contentsOfFile : imagePath!)
        
        myImageObj?.drawInRect(CGRectMake(0, 40, 320, 400))
        //myImageObj?.drawAsPatternInRect(CGRectMake(0, 0, 320, 400))

        let title:NSString = "我的小狗"
        
        let font = UIFont.systemFontOfSize(34)
        let attr = [NSFontAttributeName: font]
        title.drawAtPoint(CGPointMake(100, 20), withAttributes:attr)
        
    }

}
