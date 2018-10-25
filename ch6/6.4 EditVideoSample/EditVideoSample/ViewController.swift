//
//  ViewController.swift
//  EditVideoSample
//
//  Created by 关东升 on 15/1/28.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController,
        UIVideoEditorControllerDelegate,
        UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func editButtonPress(sender: AnyObject) {
        
        let bundle = NSBundle.mainBundle()
        let moviePath = bundle.pathForResource("YY" , ofType: "mp4")
        
        //判断设备是否支持编辑视频
        if UIVideoEditorController.canEditVideoAtPath(moviePath!) {
            
            let videoEditor = UIVideoEditorController()
            videoEditor.delegate = self
            videoEditor.videoPath = moviePath!
            self.presentViewController(videoEditor, animated: true, completion: nil)
        } else {
            NSLog("不能编辑这个视频")
        }
        
    }
    
    func videoEditorController(editor: UIVideoEditorController, didSaveEditedVideoToPath editedVideoPath: String) {
        
        editor.dismissViewControllerAnimated(true , completion: nil)
        
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(editedVideoPath) {
            UISaveVideoAtPathToSavedPhotosAlbum(editedVideoPath, self, "video:didFinishSavingWithError:contextInfo:", nil)
        }
    }
    
    //定义回调方法video:didFinishSavingWithError:contextInfo:
    func video(video: NSString, didFinishSavingWithError error : NSError?, contextInfo:UnsafeMutablePointer<Void>){
        
        var title = ""
        var message = ""
        
        if error != nil {
            title = "视频失败"
            message = error!.localizedDescription
        } else {
            title = "视频保存"
            message = "视频已经保存到设备的相机胶卷中"
        }
        
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    
    
    func videoEditorController(editor: UIVideoEditorController, didFailWithError error: NSError) {
        NSLog("编辑视频出错, %@", error)
        editor.dismissViewControllerAnimated(true , completion: nil)
    }
    
    func videoEditorControllerDidCancel(editor: UIVideoEditorController) {
        NSLog("视频编辑取消")
        editor.dismissViewControllerAnimated(true, completion:nil)
    }
}

