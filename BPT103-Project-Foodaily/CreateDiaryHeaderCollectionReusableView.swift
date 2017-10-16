//
//  CreateDiaryHeaderCollectionReusableView.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/2.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class CreateDiaryHeaderCollectionReusableView: UICollectionReusableView {
    
    let cellPadding: CGFloat = 5
    let headerY: CGFloat = 44
    let headerHeigh: CGFloat = 64
//    var headerWidth: CGFloat = 0
    let shopNameField = UITextField()
    
    
    
    func setHeader(width: CGFloat) {
        print("")
        print("目前self.frame.size的大小是：\(self.frame.size)")
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
        //        shopNameField.font = UIFont(name: "GenRyuMinTW-Regular", size: 22)
        shopNameField.font = UIFont.systemFont(ofSize: 22)
        shopNameField.sizeToFit()
        let shopNameFieldHeight = shopNameField.frame.height
        print("")
        print("目前shopNameFieldHeight是：\(shopNameFieldHeight)")
        let shopNameFieldY = blurView.frame.minY + (blurView.frame.height - shopNameFieldHeight) / 2
        
        
        shopNameField.frame = CGRect(x: blurView.frame.minX + cellPadding,
                                     y: shopNameFieldY + 1,
                                     width: blurView.frame.width - cellPadding * 2,
                                     height: shopNameFieldHeight)
        shopNameField.textAlignment = .center
        
        //        let leading = NSLayoutConstraint(item: shopNameField,
        //                                         attribute: .leading,
        //                                         relatedBy: .equal,
        //                                         toItem: blurView,
        //                                         attribute: .leading,
        //                                         multiplier: 1.0,
        //                                         constant: 5.0)
        //        let trailing = NSLayoutConstraint(item: shopNameField,
        //                                          attribute: .trailing,
        //                                          relatedBy: .equal,
        //                                          toItem: blurView,
        //                                          attribute: .trailing,
        //                                          multiplier: 1.0,
        //                                          constant: 5.0)
        //        let top = NSLayoutConstraint(item: blurView,
        //                                     attribute: .top,
        //                                     relatedBy: .equal,
        //                                     toItem: self,
        //                                     attribute: .top,
        //                                     multiplier: 1.0,
        //                                     constant: 44.0)
        //        let botton = NSLayoutConstraint(item: blurView,
        //                                        attribute: .bottom,
        //                                        relatedBy: .equal,
        //                                        toItem: self,
        //                                        attribute: .bottom,
        //                                        multiplier: 1.0,
        //                                        constant: 5.0)
        //        let snfConstraint = [leading, trailing, top]
        //
        //
        //        shopNameField.addConstraints(snfConstraint)
        
        //        let width = NSLayoutConstraint(item: blurView,
        //                                       attribute: .width,
        //                                       relatedBy: .equal,
        //                                       toItem: nil,
        //                                       attribute: .notAnAttribute,
        //                                       multiplier: 1.0,
        //                                       constant: blurViewWidth)
        //
        //        let height = NSLayoutConstraint(item: blurView,
        //                                        attribute: .height,
        //                                        relatedBy: .equal,
        //                                        toItem: nil,
        //                                        attribute: .notAnAttribute,
        //                                        multiplier: 1.0,
        //                                        constant: headerHeigh)
        //
        //        let centerX = NSLayoutConstraint(item: blurView,
        //                                         attribute: .centerX,
        //                                         relatedBy: .equal,
        //                                         toItem: self,
        //                                         attribute: .centerX,
        //                                         multiplier: 1.0,
        //                                         constant: 0.0)
        
        //        let centerY = NSLayoutConstraint(item: shopNameField,
        //                                         attribute: .centerY,
        //                                         relatedBy: .equal,
        //                                         toItem: blurView,
        //                                         attribute: .centerY,
        //                                         multiplier: 1.0,
        //                                         constant: 0.0)
        
        //        blurView.addConstraint(centerX)
        //        shopNameField.addConstraint(centerY)
        //        NSLayoutConstraint.activate([top, width, height, centerX])
        //        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.addSubview(blurView)
        self.addSubview(shopNameField)
        
    }
}
