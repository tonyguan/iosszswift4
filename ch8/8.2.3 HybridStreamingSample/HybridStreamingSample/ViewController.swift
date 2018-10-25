//
//  ViewController.swift
//  HybridStreamingSample
//
//  Created by 关东升 on 15/1/30.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.scrollView.scrollEnabled = false
        self.webView.mediaPlaybackAllowsAirPlay = true
        
        let htmlPath = NSBundle.mainBundle().pathForResource("video", ofType : "html")
        let bundleUrl = NSURL(string: htmlPath!)
        
        var error : NSError?
        
        let html = NSString(contentsOfFile: htmlPath!, encoding: NSUTF8StringEncoding, error: &error)
        
        if (error == nil) {//数据加载没有错误情况下
            self.webView.loadHTMLString(html as! String , baseURL: bundleUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

