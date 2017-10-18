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

typealias DiaryDoneHandler = (Bool, Error?, [DiaryItem]?) -> Void
typealias ImageDoneHandler = (Bool, Error?, UIImage?) -> Void
typealias WTEDoneHandler = (Bool, Error?, [WTEItem]?) -> Void

class DataManager: NSObject {
    
    var allDiary = [DiaryItem]()
    
    var allWantToEat = [WTEItem]()
    
    var foodImageArray = [UIImage]()
    
    // 宣告一個singleton物件
    static let shared: DataManager = DataManager()
    
    // 若不繼承NSObject會無法override
    private override init() {}
    
    // Firebase base REF
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    
    // Firebase Diary Database 資料路徑設定，創建一個子層叫Diary
    let DIARY_DB_REF: DatabaseReference = Database.database().reference().child("Diary")
    
    // Firebase WantToEat Database 資料路徑設定，創建一個子層叫WantToEat
    let WTE_DB_REF: DatabaseReference = Database.database().reference().child("WantToEat")
    
    // Firbase Diary storage 圖片路徑設定，創建一個子層叫Diary
    let DIARY_STORAGE_REF: StorageReference = Storage.storage().reference().child("Diary")
    
    // MARK: -日記上傳資料實作
    func uploadToFirebase(shopName: String, foodName: String, price: String, starCount: Int, noteText: String, remarkText: String, foodImage: UIImage, userName: String, foodImageWidth: String, foodImageHeight: String) {
        
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
                dateFormatter.dateFormat = "yyyy.MM.dd"
                let createTime = dateFormatter.string(from: unFormateDate)
                
                // 宣告一個字典，並將要上傳至Database內的資料放進字典中(符合JSON的結構)
                let diaryPost: [String : Any] = [
                                            DiaryItem.DirayInfoKey.shopName : shopName,
                                            DiaryItem.DirayInfoKey.foodName : foodName,
                                            DiaryItem.DirayInfoKey.price : price,
                                            DiaryItem.DirayInfoKey.starCount : starCount,
                                            DiaryItem.DirayInfoKey.noteText : noteText,
                                            DiaryItem.DirayInfoKey.remarkText : remarkText,
                                            DiaryItem.DirayInfoKey.foodImageURL : imageURL,
                                            DiaryItem.DirayInfoKey.createTime : createTime,
                                            DiaryItem.DirayInfoKey.timeStamp : timeStamp,
                                            DiaryItem.DirayInfoKey.userName : userName,
                                            DiaryItem.DirayInfoKey.foodImageWidth : foodImageWidth,
                                            DiaryItem.DirayInfoKey.foodImageHeight : foodImageHeight
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
    
    // MARK: -日記下載資料實作
    func downloadFromFirebase(doneHandler: @escaping DiaryDoneHandler) {
        
        // 先透過Firebase的內建方法將資料按照時戳(1970年至今總秒數)，由大到小(由新到舊)排列
        let diaryQuery = DIARY_DB_REF.queryOrdered(byChild: DiaryItem.DirayInfoKey.timeStamp)
        // 去針對某一特定條件去設置一個觀察者，在這邊是針對.value(任何針對資料的改動)做監聽
        diaryQuery.observe(.value) { (snapshot) in
            /// 重要，注意tempArray的位置，由於Closure的特性不可以寫在閉包外面
            var tempDiary = [DiaryItem]()
            // 注意，任何從Firebase上得到的資料都會是snapshot的型別，內容是資料在Firebase資料庫內的地址
            // 在這邊我們指定要撈出所有的資料
            for diary in snapshot.children.allObjects as! [DataSnapshot] {
                // 撈到資料後，讀取裡面的內容(.value)，由於Firebase透過JSON格式儲存資料，所以我們指定撈回來的資料為[String : Any]的字典形式
                let diaryData = diary.value as? [String : Any] ?? [:]
                // 確認有撈到資料後，將資料整包帶進allDiary內
                if let diaryPost = DiaryItem(diaryDataFromFirebase: diaryData) {
                    tempDiary.append(diaryPost)
                }
            }

            if tempDiary.count > 0 {
                // 將撈回來的資料按照時戳由大到小排列
                // 後面尾隨閉包的寫法我看不懂 by Rabo
                tempDiary.sort(by: {$0.timeStamp > $1.timeStamp})
            }
            // 把得到的allDiary放到doneHandler去當作參數，並在實際呼叫時實作
            self.allDiary = tempDiary
            doneHandler(true, nil, self.allDiary)
        }
    }
    
    // MARK: -日記下載圖片功能實作
    func downloadImage(foodImageURLString: String, imageDoneHandler: @escaping ImageDoneHandler) {
        
        // 如果撈回來的資料內的imageURL為空白，就下載預設的圖片
        if foodImageURLString == "" {
            imageDoneHandler(true, nil, UIImage(named: "00.jpg")) // 待補預設照片
            return
        }
        
        if let imageURL = URL(string: foodImageURLString) {
//            print("~~~~~~~~~~~~~~~~~~~~~")
//            print("即將要下載的照片URL是:\(imageURL)")
            let downloadTask = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                
                // 由於不能再背景碰UI，所以將圖片的載入放到主執行緒來執行
                DispatchQueue.main.async {
                
                    if let foodImage = UIImage(data: data!) {
                        foodImage.url = foodImageURLString
                        imageDoneHandler(true, error, foodImage)
                    }else{
                        print("圖片下載失敗")
                    }
                }
            })
            downloadTask.resume()
        }
    }
    
    // MARK: -日記圖片陣列
    func appendImage(image: UIImage) {
        
        foodImageArray.append(image)
    }
    
    // MARK: -日記整理圖片陣列順序
    func imageWithURL(){
        
        var imageArray = [UIImage]()
        
        for item in allDiary {
            
            let url = item.foodImageURL

            for image in foodImageArray {

                if image.url == url {
                    
                    imageArray.append(image)
                    break
                }
            }
        }
        foodImageArray = imageArray
    }
    
    // MARK: -WantToEat資料上傳實作
    func uploadWteDataToFirebase(shopName: String, remarkText: String, userName: String) {
        
        let databaseRef = WTE_DB_REF.childByAutoId()
        
        // 宣告一個時間戳記(Int)，之後在下載時可藉此來排序新舊日記
        let timeStamp = Int(Date().timeIntervalSince1970 * 1000)
        
        // 設定日期(String)要顯示的格式
        let unFormateDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let createDate = dateFormatter.string(from: unFormateDate)
        
        // 宣告wte要上傳的格式打包成字典
        let wtePost: [String : Any] = [
            WTEItem.wteInfoKey.shopName : shopName,
            WTEItem.wteInfoKey.remarkText : remarkText,
            WTEItem.wteInfoKey.createDate : createDate,
            WTEItem.wteInfoKey.timeStamp : timeStamp,
            WTEItem.wteInfoKey.userName : userName
        ]
        
        // 將資料上傳至Firebase
        databaseRef.setValue(wtePost)
    }
    
    // MARK: -WantToEat資料下載實作
    func downloadWteFromFirebase(doneHandler: @escaping WTEDoneHandler) {
        
        // 先透過Firebase的內建方法將資料按照時戳(1970年至今總秒數)，由大到小(由新到舊)排列
        let diaryQuery = WTE_DB_REF.queryOrdered(byChild: WTEItem.wteInfoKey.timeStamp)
        // 去針對某一特定條件去設置一個觀察者，在這邊是針對.value(任何針對資料的改動)做監聽
        diaryQuery.observe(.value) { (snapshot) in
            /// 重要，注意tempArray的位置，由於Closure的特性不可以寫在閉包外面
            var tempWantToEat = [WTEItem]()
            // 注意，任何從Firebase上得到的資料都會是snapshot的型別，內容是資料在Firebase資料庫內的地址
            // 在這邊我們指定要撈出所有的資料
            for wteItem in snapshot.children.allObjects as! [DataSnapshot] {
                // 撈到資料後，讀取裡面的內容(.value)，由於Firebase透過JSON格式儲存資料，所以我們指定撈回來的資料為[String : Any]的字典形式
                let wteData = wteItem.value as? [String : Any] ?? [:]
                // 確認有撈到資料後，將資料整包帶進allDiary內
                if let wtePost = WTEItem(wteDataFromFirebase: wteData) {
                    tempWantToEat.append(wtePost)
                }
            }
            
            if tempWantToEat.count > 0 {
                // 將撈回來的資料按照時戳由大到小排列
                // 後面尾隨閉包的寫法我看不懂 by Rabo
                tempWantToEat.sort(by: {$0.timeStamp > $1.timeStamp})
            }
            // 把得到的allDiary放到doneHandler去當作參數，並在實際呼叫時實作
            self.allWantToEat = tempWantToEat
            doneHandler(true, nil, self.allWantToEat)
        }
    }
}
