//
//  ViewController.swift
//  AVFoundationSample
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
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var slider: UISlider!
    
    var avPlayer : AVPlayer!
    var layer : AVPlayerLayer!
    var playerItem : AVPlayerItem!
    
    var isPlaying = false
    var timeObserver : AnyObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath = NSBundle.mainBundle().pathForResource("YY", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: filepath!)
        
        let asset = AVURLAsset(URL: fileURL, options: nil)
        self.playerItem = AVPlayerItem(asset : asset)
        self.avPlayer = AVPlayer(playerItem: self.playerItem)
        
        self.avPlayer.allowsExternalPlayback = true
        
        self.layer = AVPlayerLayer(player: self.avPlayer)
        
        self.layer.frame = CGRectMake(0, 0,
            self.view.frame.size.width,
            self.view.frame.size.height)
        
        self.view.layer.insertSublayer(self.layer, atIndex: 0)
        
        let duration = CMTimeGetSeconds(asset.duration)
        self.slider.maximumValue =  Float(duration)
        self.slider.minimumValue = 0.0
        
        //设置工具栏
        let airplayButtonView = MPVolumeView()
        airplayButtonView.sizeToFit()
        airplayButtonView.showsVolumeSlider = false
        
        let airplayButtonItem = UIBarButtonItem(customView: airplayButtonView)
        
        var items = NSMutableArray(array: self.toolBar.items!)
        items.addObject(airplayButtonItem)
        
        self.toolBar.items = items as [AnyObject]
        
        //根据视图宽度重写调整Slider的宽度
        self.slider.frame = CGRectMake(self.slider.frame.origin.x,
            self.slider.frame.origin.y,
            self.view.frame.width - 110,
            self.slider.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func play(sender: AnyObject) {
        
        var item1 : UIBarButtonItem!
        
        if !self.isPlaying {
            self.addObserver()
            self.avPlayer.play()
            self.isPlaying = true
            item1 = UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: "play:")
        } else {
            self.isPlaying = false
            item1 = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "play:")
            self.avPlayer.pause()
        }
        
        var items = NSMutableArray(array: self.toolBar.items!)
        items.replaceObjectAtIndex(0, withObject: item1)

        self.toolBar.items = items as [AnyObject]
        
    }

    
    @IBAction func seek(sender: AnyObject) {
        let value = self.slider.value
        self.avPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(value), 10))
    }

    func addObserver() {
        if self.timeObserver == nil {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.playerItem)
            
            self.timeObserver = self.avPlayer.addPeriodicTimeObserverForInterval(CMTimeMake(1, 10),
                queue: dispatch_get_main_queue(),
                usingBlock: { (time) -> Void in
                    let duration = CMTimeGetSeconds(self.avPlayer.currentTime())
                    NSLog("duration = %f",duration)
                    self.slider.value = Float(duration)
            })
            
        }
    }
    
    // MARK: --处理通知
    func playerItemDidReachEnd(notification : NSNotification) {
        NSLog("播放完成")
        
        if self.timeObserver != nil {
            
            self.avPlayer.removeTimeObserver(timeObserver)
            self.timeObserver = nil
            self.slider.value = 0.0
            self.isPlaying = false
            
            NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
            
            let item1 = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "play:")
            var items = NSMutableArray(array: self.toolBar.items!)
            items.replaceObjectAtIndex(0, withObject: item1)
            self.toolBar.items = items as [AnyObject]
            
        }
    }
}

