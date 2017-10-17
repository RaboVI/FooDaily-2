//
//  DiaryItem.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/10/14.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

struct DiaryItem {
    
    var shopName: String
    var foodName: String
    var price: String
    var starCount: Int
    var noteText: String
    var remarkText: String
    var createTime: String
    var timeStamp: Int
    var userName: String
    var foodImageURL: String
    var foodImageWidth: String
    var foodImageHeight: String
    
    // 宣告一系列在Firebase要用的Key值
    // 注意，key值必須要相同，如果與Database上的Key值不合，就會導致抓不到資料
    enum DirayInfoKey {
        static let shopName = "ShopName"
        static let foodName = "FoodName"
        static let price = "Price"
        static let starCount = "StarCount"
        static let noteText = "NoteText"
        static let remarkText = "RemarkText"
        static let createTime = "CreateTime"
        static let timeStamp = "TimeStamp"
        static let userName = "UserName"
        static let foodImageURL = "FoodImageURL"
        static let foodImageWidth = "FoodImageWidth"
        static let foodImageHeight = "FoodImageHeight"
    }
    
    // 建立第一種初始化方式
    init(shopName: String,
         foodName: String,
         price: String,
         starCount: Int,
         noteText: String,
         reamrkText: String,
         createTime: String,
         timeStamp: Int,
         userName: String,
         foodImageURL: String,
         foodImageWidth: String,
         foodImageHeight: String
        )
    {
        self.shopName = shopName
        self.foodName = foodName
        self.price = price
        self.starCount = starCount
        self.noteText = noteText
        self.remarkText = reamrkText
        self.createTime = createTime
        self.timeStamp = timeStamp
        self.userName = userName
        self.foodImageURL = foodImageURL
        self.foodImageWidth = foodImageWidth
        self.foodImageHeight = foodImageHeight
    }
    
    // 建立第二種初始化方式，當從Firebase抓取JSON格式時就採用此種初始化方法
    init?(diaryDataFromFirebase: [String : Any]) {
        guard let shopName = diaryDataFromFirebase[DirayInfoKey.shopName] as? String,
            let foodName = diaryDataFromFirebase[DirayInfoKey.foodName] as? String,
            let price = diaryDataFromFirebase[DirayInfoKey.price] as? String,
            let starCount = diaryDataFromFirebase[DirayInfoKey.starCount] as? Int,
            let noteText = diaryDataFromFirebase[DirayInfoKey.noteText] as? String,
            let remarkText = diaryDataFromFirebase[DirayInfoKey.remarkText] as? String,
            let createTime = diaryDataFromFirebase[DirayInfoKey.createTime] as? String,
            let timeStamp = diaryDataFromFirebase[DirayInfoKey.timeStamp] as? Int,
            let userName = diaryDataFromFirebase[DirayInfoKey.userName] as? String,
            let foodImageURL = diaryDataFromFirebase[DirayInfoKey.foodImageURL] as? String,
            let foodImageWidth = diaryDataFromFirebase[DirayInfoKey.foodImageWidth] as? String,
            let foodImageHeight = diaryDataFromFirebase[DirayInfoKey.foodImageHeight] as? String
        else {
            print("diaryDataFromFirebase初始化失敗")
            return nil
        }
        self = DiaryItem(shopName: shopName, foodName: foodName, price: price, starCount: starCount, noteText: noteText, reamrkText: remarkText, createTime: createTime, timeStamp: timeStamp, userName: userName, foodImageURL: foodImageURL, foodImageWidth: foodImageWidth, foodImageHeight: foodImageHeight)
    }
}
