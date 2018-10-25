//
//  ViewController.swift
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

//一行中列数
let COL_COUNT = 3

class ViewController: UIViewController,
    UICollectionViewDelegate, UICollectionViewDataSource,
    UINavigationControllerDelegate,UIViewControllerTransitioningDelegate {
    
    var datas : NSArray!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let bundle = NSBundle.mainBundle()
        let plistPath = bundle.pathForResource("Category1", ofType: "plist")
        self.datas = NSArray(contentsOfFile: plistPath!)
        
        //自定义动画
        self.navigationController?.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let button = sender as! UIButton
        let tag = button.tag
        
        //tag是集合的索引
        let dict: AnyObject = self.datas[tag]
        let id = dict["id"] as! NSNumber
        let destinationVC = segue.destinationViewController as! DetailViewController
        destinationVC.category1ID = id.integerValue
        destinationVC.category1Name = dict["name"] as! String
        destinationVC.category1Icon = dict["icon"] as! String

    }
    
    
    // MARK: --UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let count = self.datas.count / COL_COUNT
        return count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_COUNT
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCollectionViewCell
        
        let index = indexPath.section * COL_COUNT + indexPath.row
        
        if index < self.datas.count {
            let dict: AnyObject = self.datas[index]
            let image = UIImage(named: (dict["image"] as! String))
            cell.button.setImage(image, forState: .Normal)
            cell.button.tag = index//集合索引
            cell.hidden = false
        } else {
            cell.hidden = true
        }
        return cell
    }
    
    // MARK: --UINavigationControllerDelegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = HUTransitionHorizontalLinesAnimator()

        return animator
    }
    
}

