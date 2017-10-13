//
//  DataManager.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/10/8.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

// MARK: -宣告DiaryItem的模型結構
struct DiaryItem {
    
    var shopName: String
    var foodName: String
    var price: String
    var starCount: Int
    var noteText: String
    var remarkText: String
    var createDate: String
    var timeStamp: Int
    var userName: String
    var foodImage: UIImage
    
    // 宣告一系列Dairy字典要用的Key值
    enum DirayInfoKey {
        static let shopName = "ShopName"
        static let foodName = "FoodName"
        static let price = "Price"
        static let starCount = "StarCount"
        static let noteText = "NoteText"
        static let remarkText = "RemarkText"
        static let createDate = "CreateDate"
        static let timeStamp = "TimeStamp"
        static let userName = "UserName"
        static let foodImage = "FoodImage"
    }
    
    // 替變數初始化
    init(shopName: String,
         foodName: String,
         price: String,
         starCount: Int,
         noteText: String,
         reamrkText: String,
         createDate: String,
         timeStamp: Int,
         userName: String,
         foodImage: UIImage)
    {
        self.shopName = shopName
        self.foodName = foodName
        self.price = price
        self.starCount = starCount
        self.noteText = noteText
        self.remarkText = reamrkText
        self.createDate = createDate
        self.timeStamp = timeStamp
        self.userName = userName
        self.foodImage = foodImage
    }
}

// MARK: -宣告DataＭanager
class DataManager {
    
    // 宣告一個singleton物件
    static let shared: DataManager = DataManager()

    private init() {}
    
    // Firebase Datebase Reference
    // Firebase Database 資料路徑設定，創建一個子層叫Diary
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let DIARY_DB_REF: DatabaseReference = Database.database().reference().child("Diary")
    
    // Firbase Storage Reference
    // Firbase storage 圖片路徑設定，創建一個子層叫Diary
    let DIARY_STORAGE_REF: StorageReference = Storage.storage().reference().child("Diary")
    
    // MARK: -Firebase 上傳實作
    func uploadToFirebase(shopName: String, foodName: String, price: String, starCount: Int, noteText: String, remarkText: String, foodImage: UIImage, userName: String) {
        
        let databaseRef = DIARY_DB_REF.childByAutoId()
        let storageRef = DIARY_STORAGE_REF.child("\(databaseRef.key).jpg")
        
        // 將檔案大小做壓縮，(數值為0-1，數值為0檔案最小但畫質最差，數值為1檔案維持不變)
        guard let uploadData = UIImageJPEGRepresentation(foodImage, 0.7) else{
            return
        }
        
        // 建立檔案的metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // 準備上傳圖片到Storage的工作
        let uplaodTask = storageRef.putData(uploadData, metadata: metadata)
        
        // 準備一個觀察者來觀察uploadTask在成功、上傳中、失敗時要做的事
        // 當資料成功上傳時
        uplaodTask.observe(.success) { (snapshot) in
            // 當照片完整上傳至Storage時，在Database上寫入一筆資料
            // 設定要寫入Database中資料的格式，注意FIrebase Database只接受NSNumber/NSString/NSArray/NSDictionary
            if let imageURL = snapshot.metadata?.downloadURL()?.absoluteString {
                // 宣告一個時間戳記(Int)，之後在下載時可藉此來排序新舊日記
                let timeStamp = Int(Date().timeIntervalSince1970 * 1000)
                
                // 設定日期(String)要顯示的格式
                let unFormateDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
                let createTime = dateFormatter.string(from: unFormateDate)
                
                // 宣告一個字典，並將要上傳至Database內的資料放進字典中(符合JSON的結構)
                let diaryPost: [String : Any] = [
                                            DiaryItem.DirayInfoKey.shopName : shopName,
                                            DiaryItem.DirayInfoKey.foodName : foodName,
                                            DiaryItem.DirayInfoKey.price : price,
                                            DiaryItem.DirayInfoKey.starCount : starCount,
                                            DiaryItem.DirayInfoKey.noteText : noteText,
                                            DiaryItem.DirayInfoKey.remarkText : remarkText,
                                            DiaryItem.DirayInfoKey.foodImage : imageURL,
                                            DiaryItem.DirayInfoKey.createDate : createTime,
                                            DiaryItem.DirayInfoKey.timeStamp : timeStamp,
                                            DiaryItem.DirayInfoKey.userName : userName
                ]
                // 上傳資料至Database
                databaseRef.setValue(diaryPost)
            }
        }
        // 當資料正在上傳中
        uplaodTask.observe(.progress) { (snapshot) in
            // 設定一個變數在console顯示上傳的進度
            let persentComplete = 100.0 * (Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount))
            
            // 在console上印出上傳照片的進度，並以百分比顯示
            NSLog("Uploading %@.jpg...  %.1f％ complete",databaseRef.key, persentComplete)
        }
        // 當資料上傳失敗時
        uplaodTask.observe(.failure) { (snapshot) in
            
            if let error = snapshot.error {
                NSLog("檔案上傳失敗，原因：\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: -Firebase 下載實作
    func downloadFromFirebase() {
        //...
    }
    
}
