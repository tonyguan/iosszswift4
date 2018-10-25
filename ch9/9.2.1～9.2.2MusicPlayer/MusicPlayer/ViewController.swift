//
//  ViewController.swift
//  MusicPlayer
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
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songAlbumLabel: UILabel!
    @IBOutlet weak var songArtworkView: UIImageView!
    
    var iPodController : MPMusicPlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songArtworkView.image = UIImage(named : "cover.png")
        self.iPodController = MPMusicPlayerController.systemMusicPlayer()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.iPodController.playbackState == .Playing {
            self.playButton.setTitle("暂停", forState: .Normal)
        } else {
            self.playButton.setTitle("播放", forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func play(sender: AnyObject) {
        let nowPlayingItem = self.iPodController.nowPlayingItem
        
        if nowPlayingItem == nil {
            let alertView = UIAlertView(title: "提示",
                message: "请先在音乐应用中选择播放一首曲目。",
                delegate: nil,
                cancelButtonTitle: "Ok")
            alertView.show()
            return
        } else {
            self.updateView(nowPlayingItem)
        }
        
        if self.iPodController.playbackState == .Playing {
            self.iPodController.pause()
            self.playButton.setTitle("播放", forState: .Normal)
        } else {
            self.iPodController.play()
            self.playButton.setTitle("暂停", forState: .Normal)
        }
    }
    
    @IBAction func playPreviousSong(sender: AnyObject) {
        self.iPodController.skipToPreviousItem()
        self.updateView(self.iPodController.nowPlayingItem)
    }
    
    @IBAction func playNextSong(sender: AnyObject) {
        self.iPodController.skipToNextItem()
        self.updateView(self.iPodController.nowPlayingItem)
    }

    func updateView(nowPlayingItem : MPMediaItem) {
        
        self.songTitleLabel.text = nowPlayingItem.valueForProperty(MPMediaItemPropertyTitle) as? String
        self.songArtistLabel.text = nowPlayingItem.valueForProperty(MPMediaItemPropertyArtist) as? String
        self.songAlbumLabel.text = nowPlayingItem.valueForProperty(MPMediaItemPropertyAlbumTitle) as? String
        self.songArtworkView.image = UIImage(named: "cover.png")
        
        if let coverArt = nowPlayingItem.valueForProperty(MPMediaItemPropertyArtwork) as? MPMediaItemArtwork {
            let imageSize = CGSizeMake(100.0, 100.0)
            if let image = coverArt.imageWithSize(imageSize) {
                self.songArtworkView.image = image
            }
        }
    }
}

