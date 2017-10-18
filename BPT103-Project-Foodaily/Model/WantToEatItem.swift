//
//  WantToEatItem.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/10/19.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

/// WantToEat名稱過長，在此統一以wte來表示
struct WTEItem {
    
    var shopName: String
    var remarkText: String
    var createData: String
    var timeStamp: Int
    var userName: String
    
    enum wteInfoKey {
        
        static let shopName = "ShopName"
        static let remarkText = "RemarkText"
        static let createDate = "CreateDate"
        static let timeStamp = "TimeStamp"
        static let userName = "UserName"
    }
    
    init(shopName: String, remarkText: String, createDate: String, timeStamp: Int, userName: String) {
        
        self.shopName = shopName
        self.remarkText = remarkText
        self.createData = createDate
        self.timeStamp = timeStamp
        self.userName = userName
    }
    
    init?(wteDataFromFirebase: [String: Any]) {
        
        guard let shopName = wteDataFromFirebase[WTEItem.wteInfoKey.shopName] as? String,
            let reamrkText = wteDataFromFirebase[WTEItem.wteInfoKey.remarkText] as? String,
            let createDate = wteDataFromFirebase[WTEItem.wteInfoKey.createDate] as? String,
            let timeStamp = wteDataFromFirebase[WTEItem.wteInfoKey.timeStamp] as? Int,
            let userName = wteDataFromFirebase[WTEItem.wteInfoKey.userName] as? String
        else {
            print("沒有抓到wteData！")
            return nil
        }
        self = WTEItem(shopName: shopName, remarkText: reamrkText, createDate: createDate, timeStamp: timeStamp, userName: userName)
    }
}

