//
//  DetailViewController.swift
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

import UIKit
import MediaPlayer

class DetailViewController: UIViewController ,
    UITableViewDataSource,UITableViewDelegate,
UICollectionViewDelegate, UICollectionViewDataSource {
    
    var category1ID = -1
    var category1Name = ""
    var category1Icon = ""
    var color : UIColor!
    
    var tableData : NSArray!
    var collectionData : NSArray!
    var moviePlayerVC : MPMoviePlayerViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title  = self.category1Name
        
        //注册 根据类别1查询类别2 成功通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findC2ByC1Finished:",
            name: findC2ByC1FinishedNotification, object: nil)
        
        //注册 根据类别1查询类别2 失败通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findC2ByC1Failed:",
            name: findC2ByC1FailedNotification, object: nil)
        
        //注册 根据类别2查询课程 成功通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findCourseFinished:",
            name: findCByC2FinishedNotification, object: nil)
        
        //注册 根据类别2查询课程 失败通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findCourseFailed:",
            name: findCByC2FailedNotification, object: nil)
        
        //注册 根据类别1查询课程 成功通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findCourseFinished:",
            name: findCByC1FinishedNotification, object: nil)
        
        //注册 根据类别1查询课程 失败通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "findCourseFailed:",
            name: findCByC1FailedNotification, object: nil)
        
        //根据类别1查询类别2
        let stub = BusinessLogicStub.sharedInstance
        stub.findCategory2ByCategory1(category1ID)
        //根据类别1查询课程
        stub.findCourseByCategory1(category1ID)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: 通知回调方法
    //根据类别1查询类别2 成功
    func findC2ByC1Finished(notification: NSNotification) {
        let res = notification.object as! [String : AnyObject]
        let resultCodeObj = res["ResultCode"] as! NSNumber
        if resultCodeObj.integerValue >= 0 {
            self.tableData = res["Record"] as! [AnyObject]
        }
        self.tableView.reloadData()
    }
    
    //根据类别1查询类别2 失败
    func findC2ByC1Failed(notification: NSNotification)  {
        self.tableData = nil
        self.tableView.reloadData()
    }
    
    //根据类别2查询课程、根据类别1查询课程 成功
    func findCourseFinished(notification: NSNotification)  {
        let res = notification.object as! [String : AnyObject]
        let resultCodeObj = res["ResultCode"] as! NSNumber
        if resultCodeObj.integerValue >= 0 {
            self.collectionData = res["Record"] as! [AnyObject]
        }
        self.collectionView.reloadData()
    }
    
    //根据类别2查询课程、根据类别1查询课程 失败
    func findCourseFailed(notification: NSNotification)  {
        self.collectionData = nil
        self.collectionView.reloadData()
    }
    
    // MARK: --UITableViewDataSource 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data = self.tableData {
            return data.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        let rowDict = self.tableData[row] as! [String : AnyObject]
        
        cell.textLabel?.text =  rowDict["name"] as? String
        cell.imageView?.image =  UIImage(named: self.category1Icon)
        
        return cell
    }
    
    // MARK: --UITableViewDelegate 协议方法
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let rowDict = self.tableData[row] as! [String : AnyObject]
        let id = rowDict["ID"] as! NSNumber
        
        //根据类别2查询课程列表
        let stub = BusinessLogicStub.sharedInstance
        stub.findCourseByCategory2(id.integerValue)
    }
    
    // MARK: --UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if let data = self.collectionData {
            var count = data.count / COL_COUNT
            if data.count % COL_COUNT != 0 {
                count++
            }
            return count
        }
        return 0
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_COUNT
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DetailCollectionViewCell
        
        let index = indexPath.section * COL_COUNT + indexPath.row
        
        if index < self.collectionData.count {
            
            let dict = self.collectionData[index] as! [String : AnyObject]
            
            cell.lblName.lineBreakMode = NSLineBreakMode.ByTruncatingTail
            cell.lblTeacher.text = String(format: "主讲人：%@", dict["Teacher"] as! String)
            cell.lblPeopleNumber.text = String(format: "人学习：%@", dict["PeopleNumber"] as! NSNumber)
            cell.lblClassHour.text = String(format: "共%@课时", dict["ClassHour"] as! NSNumber)
            
            let numCharges = dict["Charges"] as! NSNumber
            if numCharges.floatValue == 0.0 {
                cell.lblCharges.text = "免费"
            } else {
                cell.lblCharges.text = String(format: "%@元",numCharges)
            }
            
            //异步加载图片
            let strImgkURL = String(format: "http://%@/%@/%@",hostName,Streaming_Media_URL_BASE, dict["Picture"] as! String)
            let imgkURL = NSURL(string: strImgkURL)
            
            let downloadQueue = dispatch_queue_create("Image.downloader", nil)
            dispatch_async(downloadQueue, { () -> Void in
                let imgData = NSData(contentsOfURL: imgkURL!)
                let img = UIImage(data:imgData!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.imageView.image = img
                })
            })
            cell.hidden = false
        } else {
            cell.hidden = true
        }
        
        return cell
    }
    
    // MARK: --UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let dict = self.collectionData[indexPath.section * COL_COUNT + indexPath.row] as! [String : AnyObject]
        
        let strURL = String(format: "http://%@/%@/%@",hostName,Streaming_Media_URL_BASE, dict["URL"] as! String)
        
        let url = NSURL(string: strURL)
        
        self.play(url!)
    }
    
    func play(movieURL : NSURL) {
        self.moviePlayerVC = MPMoviePlayerViewController(contentURL: movieURL)
        self.moviePlayerVC.moviePlayer.scalingMode = .Fill
        self.moviePlayerVC.moviePlayer.controlStyle = .Fullscreen
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playbackFinished4MoviePlayerViewController:",
            name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        
        self.presentMoviePlayerViewControllerAnimated(self.moviePlayerVC)
    }
    
    
    func playbackFinished4MoviePlayerViewController(not : NSNotification) {
        NSLog("使用MPMoviePlayerViewController播放完成.")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        self.moviePlayerVC.dismissMoviePlayerViewControllerAnimated()
        self.moviePlayerVC = nil
    }
    
}
