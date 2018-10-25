//
//  ViewController.swift
//  SpeechSynthesis
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
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate, UITextViewDelegate {
    
    var speechSynthesizer : AVSpeechSynthesizer!
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func speakButtonWasPressed(sender: AnyObject) {
        
        var utt = AVSpeechUtterance(string: self.textView.text)
        utt.rate = self.slider.value
        self.speechSynthesizer.speakUtterance(utt)
        
    }
    
    @IBAction func speechSpeedShouldChange(sender: AnyObject) {
        let slider = sender as! UISlider
        NSLog("%f", slider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置TextView
        self.textView.layer.borderWidth = 0.5
        self.textView.layer.borderColor = UIColor.grayColor().CGColor
        self.textView.delegate = self
        
        self.speechSynthesizer = AVSpeechSynthesizer()
        self.speechSynthesizer.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: --实现UITextViewDelegate协议
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var retval = true
        if text == "\n" {
            self.textView.resignFirstResponder()
            retval = false
        }
        return retval
    }
    
    
    // MARK: --实现AVSpeechSynthesizerDelegate协议
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        NSLog("语音合成开始。")
        
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        NSLog("语音合成完成。")
    }
}

