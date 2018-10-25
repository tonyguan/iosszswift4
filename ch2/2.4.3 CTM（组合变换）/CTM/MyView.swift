//
//  MyView.swift
//  CTM
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
        
        let path = NSBundle.mainBundle().pathForResource("cat", ofType: "png")
        let img  = UIImage(contentsOfFile : path!)
        let image = img!.CGImage
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        CGContextTranslateCTM(context, 0, img!.size.height)
        CGContextScaleCTM(context, 1, -1)
        
        let touchRect = CGRectMake(0, 0, img!.size.width, img!.size.height)
        
        CGContextDrawImage(context, touchRect, image)
        
        CGContextRestoreGState(context)
    }
    
}
