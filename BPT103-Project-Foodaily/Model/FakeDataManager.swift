//
//  FakeDataManager.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

struct daily {
    var shopName = String()
    var foodName = String()
    var createDate = String()
    var starCount = Int()
    var image = UIImage()
    
}

class FakeDataManager: NSObject {
    
    static let shared = FakeDataManager()
    
    var wantToEatArray = [Dictionary<String, String>]()
    
    private override init() {
        dailyItem = [data0, data1, data2, data3, data4, data5, data6]
        
        wantToEatArray = [wantToEatDict1, wantToEatDict2, wantToEatDict3]
    }
    
    let wantToEatDict1 = [
        "ShopName" : "Lamb",
        "RemarkText" : "10491台北市中山區吉林路327號，營業時間17:00-01:00，羊排看起來不錯吃"
    ]
    
    let wantToEatDict2 = [
        "ShopName" : "Michael's kitchen",
        "RemarkText" : "100台北市中正區徐州路26號，需要預訂，電話：02-23221880"
    ]
    
    let wantToEatDict3 = [
        "ShopName" : "青島排骨",
        "RemarkText" : "排骨看起來很厚，價格看起來也很平價。 \n電話：02-2357 7649\n地址：100台北市中正區青島東路3-3號"
    ]
//    var dailyImage = [UIImage(named: "00.jpg"),
//                      UIImage(named: "01.jpg"),
//                      UIImage(named: "02.jpg"),
//                      UIImage(named: "03.jpg"),
//                      UIImage(named: "04.jpg"),
//                      UIImage(named: "05.jpg"),
//                      UIImage(named: "06.jpg")]
    
    let data0 = daily(shopName: "JE Kitchen",
                      foodName: "馬鈴薯慕斯",
                      createDate: "2017/09/20",
                      starCount: 3,
                      image: UIImage(named: "00.jpg")!)
    
    let data1 = daily(shopName: "有春小吃店",
                      foodName: "青醬鮮菇雞麵",
                      createDate: "2017/09/21",
                      starCount: 4,
                      image: UIImage(named: "01.jpg")!)
    
    let data2 = daily(shopName: "金雞母 Jingimoo",
                      foodName: "春暖大花玫瑰冰",
                      createDate: "2017/09/22",
                      starCount: 2,
                      image: UIImage(named: "02.jpg")!)
    
    let data3 = daily(shopName: "9宮格早午餐",
                      foodName: "義式環遊世界9宮格套餐",
                      createDate: "2017/09/23",
                      starCount: 5,
                      image: UIImage(named: "03.jpg")!)
    
    let data4 = daily(shopName: "泔米食堂",
                      foodName: "泔湯桂花釀",
                      createDate: "2017/09/24",
                      starCount: 4,
                      image: UIImage(named: "04.jpg")!)
    
    let data5 = daily(shopName: "淼淼特調水搖飲",
                      foodName: "愛玉檸檬",
                      createDate: "2017/09/25",
                      starCount: 2,
                      image: UIImage(named: "05.jpg")!)
    
    let data6 = daily(shopName: "乂鬼氏卍食堂乂",
                      foodName: "樂樂鍋燒意麵",
                      createDate: "2017/09/26",
                      starCount: 5,
                      image: UIImage(named: "06.jpg")!)
    
    
    var dailyItem = [daily]()
    
    
    private func setting() {
        
    }
    
}
