//
//  BusinessLogicStub.swift
//  School
//
//  Created by 关东升 on 15/2/2.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import Foundation

//定义 根据类别1查询类别2 成功通知
let	findC2ByC1FinishedNotification  =  "findCategory2ByCategory1FinishedNotification"
//定义 根据类别1查询类别2 失败通知
let	findC2ByC1FailedNotification    =  "findCategory2ByCategory1FailedNotification"

//定义 根据类别2查询课程 成功通知
let	findCByC2FinishedNotification   =   "findCourseByCategory2FinishedNotification"
//定义 根据类别2查询课程 失败通知
let	findCByC2FailedNotification     =   "findCourseByCategory2FailedNotification"

//定义 根据类别1查询课程 成功通知
let	findCByC1FinishedNotification   =   "findCourseByCategory1FinishedNotification"
//定义 根据类别1查询课程 失败通知
let	findCByC1FailedNotification     =   "findCourseByCategory1FailedNotification"

//Webservice基础URL
let Webservice_URL_BASE       = "school"
//流媒体服务URL
let Streaming_Media_URL_BASE  = "stream"
//主机名
let hostName = "localhost"

class BusinessLogicStub {
    
    class var sharedInstance: BusinessLogicStub {
        struct Static {
            static var instance: BusinessLogicStub?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = BusinessLogicStub()
        }
        
        return Static.instance!
    }
    
    
    /**
    * 根据类别1查询类别2
    */
    func findCategory2ByCategory1(cid1 : Int) {
        
        let strURL = String(format: "%@/BusinessLogicSkeleton.php?action=q1&cid1=%i", Webservice_URL_BASE, cid1)
        
        var engine = MKNetworkEngine(hostName: hostName, customHeaderFields: nil)
        var op = engine.operationWithPath(strURL)
        
        op.addCompletionHandler({ (operation) -> Void in
            
            let data  = operation.responseData()
            
            //NSLog("findCategory2ByCategory1 %@",operation.responseString())
            
            if data != nil && data.length > 0 {
                let resDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! [NSObject : AnyObject]
                
                NSNotificationCenter.defaultCenter().postNotificationName(findC2ByC1FinishedNotification, object: resDict )
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(findC2ByC1FailedNotification, object: nil)
            }
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                NSNotificationCenter.defaultCenter().postNotificationName(findC2ByC1FailedNotification, object: err)
        })
        
        engine.enqueueOperation(op)
        
    }
    
    /**
    * 根据类别2查询课程
    */
    func findCourseByCategory2(cid2 : Int) {
        
        let strURL = String(format: "%@/BusinessLogicSkeleton.php?action=q2&cid2=%i",Webservice_URL_BASE,cid2)
        
        var engine = MKNetworkEngine(hostName: hostName, customHeaderFields: nil)
        var op = engine.operationWithPath(strURL)
        
        op.addCompletionHandler({ (operation) -> Void in
            
            let data  = operation.responseData()
            //NSLog("findCourseByCategory2 %@",operation.responseString())
            
            if data != nil && data.length > 0 {
                let resDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! [String : AnyObject]
                
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC2FinishedNotification, object: resDict)
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC2FailedNotification, object: nil)
            }
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC2FailedNotification, object: err)
        })
        
        engine.enqueueOperation(op)
    }
    
    /**
    * 根据类别1查询课程
    */
    func findCourseByCategory1(cid1 : Int) {
        let strURL = String(format: "%@/BusinessLogicSkeleton.php?action=q3&cid1=%i",Webservice_URL_BASE,cid1)
       
        var engine = MKNetworkEngine(hostName: hostName, customHeaderFields: nil)
        var op = engine.operationWithPath(strURL)
        
        op.addCompletionHandler({ (operation) -> Void in
            let data  = operation.responseData()
            //NSLog("findCourseByCategory1 %@",operation.responseString())
  
            if data != nil && data.length > 0 {
                let resDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:nil) as! [String : AnyObject]
                
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC1FinishedNotification, object: resDict )
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC1FailedNotification, object: nil)
            }
            }, errorHandler: { (operation, err) -> Void in
                NSLog("MKNetwork请求错误 : %@", err.localizedDescription)
                NSNotificationCenter.defaultCenter().postNotificationName(findCByC1FailedNotification, object: err)
        })
        
        engine.enqueueOperation(op)
    }
    
}
