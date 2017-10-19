//
//  AddWantToEatHeaderCollectionReusableView.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class AddWantToEatHeaderCollectionReusableView: UICollectionReusableView {
    
    let cellPadding: CGFloat = 5
    let headerY: CGFloat = 44
    let headerHeigh: CGFloat = 64
    let shopNameField = UITextField()
    
    
    
    func setHeader(width: CGFloat) {
//        print("目前self.frame.size的大小是：\(self.frame.size)")
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        let blurViewWidth = width - cellPadding * 2
        let blurViewX = (self.frame.width - blurViewWidth) / 2
        blurView.frame = CGRect(x: blurViewX,
                                y: headerY,
                                width: blurViewWidth,
                                height: headerHeigh)
        blurView.layer.cornerRadius = 15
        blurView.layer.shadowOffset = CGSize(width: 1, height: 1)
        blurView.layer.shadowOpacity = 0.2
        blurView.layer.shadowRadius = 3.5
        blurView.layer.shadowColor = UIColor(red: 44.0/255.0,
                                             green: 62.0/255.0,
                                             blue: 80.0/255.0,
                                             alpha: 1.0).cgColor
        blurView.clipsToBounds = true
        self.backgroundColor = UIColor.clear
        
        
        shopNameField.placeholder = "店 家 名 稱"
        shopNameField.font = UIFont.systemFont(ofSize: 22)
        shopNameField.sizeToFit()
        let shopNameFieldHeight = shopNameField.frame.height
//        print("")
//        print("目前shopNameFieldHeight是：\(shopNameFieldHeight)")
        let shopNameFieldY = blurView.frame.minY + (blurView.frame.height - shopNameFieldHeight) / 2
        
        
        shopNameField.frame = CGRect(x: blurView.frame.minX + cellPadding,
                                     y: shopNameFieldY + 1,
                                     width: blurView.frame.width - cellPadding * 2,
                                     height: shopNameFieldHeight)
        shopNameField.textAlignment = .center
        
        self.addSubview(blurView)
        self.addSubview(shopNameField)
        
    }
}
