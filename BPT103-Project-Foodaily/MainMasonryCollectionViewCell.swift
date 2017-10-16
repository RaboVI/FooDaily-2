//
//  MainMasonryCollectionViewCell.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

let cellPadding: CGFloat = 5

let bgPadding: CGFloat = 10

/// 創建時間與評分之空間高度
let commentStampHeight: CGFloat = 20

let imagePadding: CGFloat = 10


class MainMasonryCollectionViewCell: UICollectionViewCell {    
    
    let bg = UIView()
    
    let imageView = UIImageView()
    
    func setCellDetail(image: UIImage,
                       shopName: String,
                       createDate: String,
                       starCount: Int,
                       width: CGFloat) {
        
        let imageSize = computeImage(image: image,
                                     width: width)
        
        setBgAndImage(width: width,
                      image: image,
                      imageSize: imageSize)
        
        setShopName(shopName: shopName,
                    imageSize: imageSize)
        
        setCreateDateAndStarCount(date: createDate,
                                  star: starCount,
                                  imageSize: imageSize)
    }
    
    
    private func computeImage(image: UIImage,
                              width: CGFloat) -> CGSize {
        
        let imageWidth = width - cellPadding * 2 - bgPadding * 2
        
        let height = image.size.height * imageWidth / image.size.width
        
        return CGSize(width: imageWidth, height: height)
    }
    
    
    private func setBgAndImage(width: CGFloat,
                               image: UIImage,
                               imageSize: CGSize) {
        
        bg.frame = CGRect(x: cellPadding,
                          y: cellPadding,
                          width: width - cellPadding * 2,
                          height: imageSize.height + bgPadding * 2 + commentStampHeight)
        
        imageView.frame = CGRect(x: cellPadding + bgPadding,
                                 y: cellPadding + bgPadding,
                                 width: imageSize.width,
                                 height: imageSize.height)
        
        imageView.image = image
        
        bg.layer.cornerRadius = 7.5
        imageView.layer.cornerRadius = 5
//        bg.clipsToBounds = true
        imageView.clipsToBounds = true
        
        bg.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        bg.layer.shadowOffset = CGSize(width: 1, height: 1)
        bg.layer.shadowOpacity = 0.2
        bg.layer.shadowRadius = 3.5
        bg.layer.shadowColor = UIColor(red: 44.0/255.0,
                                       green: 62.0/255.0,
                                       blue: 80.0/255.0,
                                       alpha: 1.0).cgColor
        
        
        
        self.addSubview(bg)
        self.addSubview(imageView)
        
    }
    
    
    private func setShopName(shopName: String,
                             imageSize: CGSize) {
        let labelMargin = cellPadding + bgPadding + imagePadding
        let labelWidth = imageSize.width - imagePadding * 2
        
        let labelHeight = imageSize.height - imagePadding * 2
        
        let shopNameLabel = UILabel()
        
        shopNameLabel.font = UIFont(name: "GenRyuMinTW-Bold", size: 24)
    
        shopNameLabel.text = shopName
        
        shopNameLabel.numberOfLines = 0
        
        shopNameLabel.textColor = UIColor.white
        
        shopNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        shopNameLabel.layer.shadowOpacity = 1
        shopNameLabel.layer.shadowRadius = 1
        shopNameLabel.layer.shadowColor = UIColor(red: 0/255.0,
                                                  green: 0/255.0,
                                                  blue: 0/255.0,
                                                  alpha: 1.0).cgColor
        
        shopNameLabel.frame = CGRect(x: labelMargin,
                                     y: labelMargin,
                                     width: labelWidth,
                                     height: labelHeight)
        
        shopNameLabel.changeWordSpace(space: 1)
        
        self.addSubview(shopNameLabel)
        
    }
    
    
    private func setCreateDateAndStarCount(date: String,
                                           star: Int,
                                           imageSize: CGSize) {
        
        let createDateLabel = UILabel()
        let textColor = #colorLiteral(red: 0.5362349749, green: 0.385327965, blue: 0.3359507322, alpha: 1)
        let textX = cellPadding + bgPadding
        let textY = cellPadding + bgPadding + imageSize.height
        let textH = commentStampHeight + bgPadding
        let textW = imageSize.width
        

        createDateLabel.font = UIFont(name: "Akrobat-Bold", size: 14)
        createDateLabel.textColor = textColor
        createDateLabel.text = date
        createDateLabel.changeWordSpace(space: 1.5)
        createDateLabel.frame = CGRect(x: textX,
                                       y: textY,
                                       width: textW,
                                       height: textH)
        
        self.addSubview(createDateLabel)
        
        
        let star1 = UIImageView()
        let star2 = UIImageView()
        let star3 = UIImageView()
        let star4 = UIImageView()
        let star5 = UIImageView()
        let starArray: [UIImageView] = [star1, star2, star3, star4, star5]
        
        
        let starSize = CGSize(width: 10, height: 10)
        
        let starSpacing: CGFloat = 2.5
        
        var starX = self.frame.width - cellPadding - bgPadding
        
        let starY = cellPadding + bgPadding + imageSize.height + (commentStampHeight + bgPadding) / 2 - starSize.height / 2
        
        for star in starArray {
            starX -= (starSize.width + starSpacing)
            star.image = UIImage(named: "hollowStar.png")
            star.frame = CGRect(x: starX,
                                y: starY,
                                width: starSize.width,
                                height: starSize.height)
            
            star.layer.shadowOffset = CGSize(width: 1, height: 1)
            star.layer.shadowOpacity = 0.15
            star.layer.shadowRadius = 0.5
            star.layer.shadowColor = UIColor(red: 20/255.0,
                                             green: 20/255.0,
                                             blue: 0/255.0,
                                             alpha: 1.0).cgColor
        }
        
        for i in 0..<star {
            
            starArray[i].image = UIImage(named: "solidStar.png")
        }
        
        for star in starArray {
            self.addSubview(star)
        }
        
    }
    
   
    class func computeCellSize(image: UIImage,
                               width: CGFloat) -> CGSize {
        
        let imageMargin = cellPadding * 2 + bgPadding * 2
        
        let height = image.size.height * (width - imageMargin) / image.size.width + imageMargin + commentStampHeight
        
        return CGSize(width: width, height: height)
    }

}
