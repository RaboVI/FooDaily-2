//
//  FakeDataManager.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FakeDataManager: NSObject {

    var dailyItem = [daily]()

    static let shared = FakeDataManager()
    
//    private override init() {
//        dailyItem = [data0, data1, data2, data3, data4, data5, data6]
        
//    }
//
    //    var dailyImage = [UIImage(named: "00.jpg"),
    //                      UIImage(named: "01.jpg"),
    //                      UIImage(named: "02.jpg"),
    //                      UIImage(named: "03.jpg"),
    //                      UIImage(named: "04.jpg"),
    //                      UIImage(named: "05.jpg"),
    //                      UIImage(named: "06.jpg")]
    
//    let data0 = daily(shopName: "JE Kitchen",
//                      foodName: "馬鈴薯慕斯",
//                      createDate: "2017/09/20",
//                      starCount: 3,
//                      image: UIImage(named: "00.jpg")!)
//
//    let data1 = daily(shopName: "有春小吃店",
//                      foodName: "青醬鮮菇雞麵",
//                      createDate: "2017/09/21",
//                      starCount: 4,
//                      image: UIImage(named: "01.jpg")!)
//
//    let data2 = daily(shopName: "金雞母 Jingimoo",
//                      foodName: "春暖大花玫瑰冰",
//                      createDate: "2017/09/22",
//                      starCount: 2,
//                      image: UIImage(named: "02.jpg")!)
//
//    let data3 = daily(shopName: "9宮格早午餐",
//                      foodName: "義式環遊世界9宮格套餐",
//                      createDate: "2017/09/23",
//                      starCount: 5,
//                      image: UIImage(named: "03.jpg")!)
//
//    let data4 = daily(shopName: "泔米食堂",
//                      foodName: "泔湯桂花釀",
//                      createDate: "2017/09/24",
//                      starCount: 4,
//                      image: UIImage(named: "04.jpg")!)
//
//    let data5 = daily(shopName: "淼淼特調水搖飲",
//                      foodName: "愛玉檸檬",
//                      createDate: "2017/09/25",
//                      starCount: 2,
//                      image: UIImage(named: "05.jpg")!)
//
//    let data6 = daily(shopName: "乂鬼氏卍食堂乂",
//                      foodName: "樂樂鍋燒意麵",
//                      createDate: "2017/09/26",
//                      starCount: 5,
//                      image: UIImage(named: "06.jpg")!)
//
    

    func loadData() {

        let POST_DB_REF: DatabaseReference = Database.database().reference().child("posts")
        let postQuery = POST_DB_REF.queryOrdered(byChild: "timestamp")
        var postfeed: [Post] = []
        
        postQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                let postInfo = item.value as? [String: Any] ?? [:]
                
                if let post = Post(postId: item.key, postInfo: postInfo) {
                    postfeed.append(post)
                    print(post)
                    print("postfeed.count : \(postfeed.count)")

                }
            }
        })
        print("FakeDataManager: for loop postfeed.count \(postfeed.count)")
        for i in 0..<postfeed.count {
            var uiImage = UIImage()
            if let image = CacheManager.shared.getFromCache(key: postfeed[i].imageFileURL) as? UIImage {
                uiImage = image
                
            } else {
                if let url = URL(string: postfeed[i].imageFileURL) {
                    
                    let downloadTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                        
                        guard let imageData = data else {
                            return
                        }
                        
                        OperationQueue.main.addOperation {
                            guard let uiImage = UIImage(data: imageData) else { return }
                            
                            // Only display the image when it is showing the current post
                            // Sometimes, the user just scrolls too fast. If the image download
                            // speed can't keep up with the scrolling speed, the cell's image
                            // will be overwritten multiple times. By adding a simple
                            // check, we can prevent this issue.
//                            if self.currentPost?.imageFileURL == post.imageFileURL {
//                                self.photoImageView.image = image
//                            }
                            
                            // Add the downloaded image to cache
                            CacheManager.shared.cache(object: uiImage, key: postfeed[i].imageFileURL)
                        }
                        
                    })
                    
                    downloadTask.resume()
                }// if let url
            }//if let image
            let data = daily(shopName: postfeed[i].shopName, foodName: postfeed[i].foodName, createDate: postfeed[i].createDate, starCount: postfeed[i].votes, image: uiImage)
            dailyItem.append(data)
        } // for loop
        print("FakeDataManager: dailyItem")
        print(dailyItem)
    }
    
}

struct daily {
    var shopName = String()
    var foodName = String()
    var createDate = String()
    var starCount = Int()
    var image = UIImage()
}
