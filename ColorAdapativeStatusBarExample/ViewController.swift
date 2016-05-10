//
//  ViewController.swift
//  ColorAdapativeStatusBarExample
//
//  Created by Simon on 2016/4/18.
//  Copyright © 2016年 Simon. All rights reserved.
//

import UIKit

struct K {
    static let bannerImageHeight: CGFloat = 200.0
    static let bannerBackgroundHeight: CGFloat = 40.0
}

class ViewController: UIViewController, UIScrollViewDelegate {
    
    // 顯示Banner區塊的ScrollView
    var mainScrollView: UIScrollView!
    
    // 當成StatusBar背景色的ScrollView
    var statusBarScrollView: UIScrollView!
    
    
    // Banner背景色
    let bannerBGColorAry: [UIColor] = [
        UIColor(hex: 0xFF60AF),
        UIColor(hex: 0xFFD306),
        UIColor(hex: 0x73BF00),
        UIColor(hex: 0x0080FF),
        UIColor(hex: 0xEA7500)
    ]
    
    // Banner圖片
    let bannerImageAry: [UIImage] = [
        UIImage(named: "Flower")!,
        UIImage(named: "Type")!,
        UIImage(named: "Leaf")!,
        UIImage(named: "Sky")!,
        UIImage(named: "Rock")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
        let bannerHeight: CGFloat = K.bannerImageHeight + K.bannerBackgroundHeight
        
        // 設定Banner區塊的ScrollView
        self.mainScrollView = UIScrollView()
        self.mainScrollView.frame = UIScreen.mainScreen().bounds
        self.mainScrollView.delegate = self
        self.mainScrollView.contentSize = CGSizeMake(screenWidth, bannerHeight * CGFloat(bannerBGColorAry.count))
        self.view.addSubview(self.mainScrollView)
        
        // 將Banner區塊加到ScrollView
        for (index,  bgColor) in self.bannerBGColorAry.enumerate() {
            // 載入Banner的背景色
            let yPos = CGFloat(index) * bannerHeight
            let banner = UIView(frame: CGRectMake(0, yPos, screenWidth, bannerHeight))
            banner.backgroundColor = bgColor
            
            // 載入Banner的照片
            let bannerImage: UIImageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, K.bannerImageHeight))
            bannerImage.image = self.bannerImageAry[index]
            bannerImage.contentMode = UIViewContentMode.ScaleAspectFill
            bannerImage.clipsToBounds = true
            banner.addSubview(bannerImage)
            
            self.mainScrollView.addSubview(banner)
        }
        
        
        // 設定StatusBar背景色的ScrollView
        self.statusBarScrollView = UIScrollView()
        self.statusBarScrollView.userInteractionEnabled = false
        self.statusBarScrollView.showsHorizontalScrollIndicator = false
        self.statusBarScrollView.showsVerticalScrollIndicator = false
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        self.statusBarScrollView.frame = CGRectMake(0, 0, screenWidth, statusBarHeight)
        self.statusBarScrollView.contentSize = self.mainScrollView.contentSize
        self.view.addSubview(self.statusBarScrollView)
        
        // 只載入Banner的背景色
        for (index,  bgColor) in self.bannerBGColorAry.enumerate() {
            let yPos = CGFloat(index) * bannerHeight
            let banner = UIView(frame: CGRectMake(0, yPos, screenWidth, bannerHeight))
            banner.backgroundColor = bgColor
            
            self.statusBarScrollView.addSubview(banner)
        }
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        // 讓statusBarScrollView跟著mainScrollView連動，就可以讓StatusBar的底色跟著改變。
        self.statusBarScrollView.contentOffset = self.mainScrollView.contentOffset
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}
