//
//  DailyItem.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class DailyItem {

    let bg = UIView()
    
    let imageView = UIImageView()
    
//    let image: [UIImage]
//    
//    let shopName: String
//    
//    let foodName: [String]
//    
//    let createDate: String
//    
//    let starCount: Int
//    
//    let width: CGFloat
    
    init(image: [UIImage],
         shopName: String,
         foodName: [String],
         createDate: String,
         starCount: Int,
         width: CGFloat) {
        
//        self.image = image
//        self.shopName = shopName
//        self.foodName = foodName
//        self.createDate = createDate
//        self.starCount = starCount
//        self.width = width
        
        guard let firstImage = image.first else { return }
        
        let imageSize = computeImage(image: firstImage,
                                     width: width)
        
        setBgAndImage(width: width,
                      image: firstImage,
                      imageSize: imageSize)
        
        guard let firstFoodName = foodName.first else { return }
        
        setShopNameAndFoodName(shopName: shopName,
                               foodName: firstFoodName,
                               imageSize: imageSize)
        
        setCreateDateAndStarCount(date: createDate,
                                  star: starCount,
                                  imageSize: imageSize)
        
    }
    
    
    private func computeImage(image: UIImage,
                      width: CGFloat) -> CGSize {
        
        let height = image.size.height * width / image.size.width
        
        return CGSize(width: width, height: height)
    }
    
    
    private func setBgAndImage(width: CGFloat,
                       image: UIImage,
                       imageSize: CGSize) {
        
        bg.frame = CGRect(x: 0,
                          y: 0,
                          width: width,
                          height: imageSize.height + 60)
        
        imageView.frame = CGRect(x: 20,
                                 y: 20,
                                 width: imageSize.width,
                                 height: imageSize.height)
        
        imageView.image = image
    }
    
    
    private func setShopNameAndFoodName(shopName: String,
                                foodName: String,
                                imageSize: CGSize) {
        
    }
    
    
    private func setCreateDateAndStarCount(date: String,
                                           star: Int,
                                           imageSize: CGSize) {
        
    }
}
