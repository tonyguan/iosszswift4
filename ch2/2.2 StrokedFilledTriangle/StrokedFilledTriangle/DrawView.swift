//
//  DrawView.swift
//  StrokedFilledTriangle
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

class DrawView: UIView {

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, 75, 10)
        CGContextAddLineToPoint(context, 10, 150)
        CGContextAddLineToPoint(context, 160, 150)
        CGContextClosePath(context)
        
        // 设置黑色描边参数
        UIColor.blackColor().setStroke()
        // 设置红色条填充参数
        UIColor.greenColor().setFill()
        CGContextSaveGState(context)
        UIColor.redColor().setFill()
        CGContextRestoreGState(context)
        
        //绘制路径
        CGContextDrawPath(context, kCGPathFillStroke)

    }

}
