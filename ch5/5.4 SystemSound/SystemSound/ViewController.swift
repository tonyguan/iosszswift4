//
//  ViewController.swift
//  SystemSound
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
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func playSystemSound(sender: AnyObject) {
        
        let system_sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("AlertChordStroke", ofType: "wav")!)
        
        var system_sound_id : SystemSoundID = 0
        
        //创建SystemSoundID
        AudioServicesCreateSystemSoundID(system_sound_url, &system_sound_id)
        
        //注册声音播放完成事件回调函数。
        AudioServicesAddSystemSoundCompletion(
            system_sound_id,
            nil ,
            nil ,
            completionHandler() , //Help.c中定义
            nil
        )
        //播放系统声音
        AudioServicesPlaySystemSound(system_sound_id)
    }
    
    @IBAction func alert(sender: AnyObject) {
        let system_sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("BeepGMC500", ofType: "wav")!)
        
        var system_sound_id : SystemSoundID = 0
        
        //创建SystemSoundID
        AudioServicesCreateSystemSoundID(system_sound_url, &system_sound_id)
        
        //注册声音播放完成事件回调函数。
        AudioServicesAddSystemSoundCompletion(
            system_sound_id,
            nil ,
            nil ,
            completionHandler() , //Help.c中定义
            nil
        )
        // 发出警告
        AudioServicesPlayAlertSound(system_sound_id)
    }
    
    @IBAction func vibrate(sender: AnyObject) {
        let deviceModel = UIDevice.currentDevice().model
        NSLog("设备：%@",deviceModel)
        
        if deviceModel == "iPhone" {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            let alertView = UIAlertView(title: "提示", message: "设备不支持", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        }
    }

}

