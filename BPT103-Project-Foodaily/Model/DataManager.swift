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

typealias DoneHandler = (Bool, Error?, [DiaryItem]?) -> Void
typealias ImageDoneHandler = (Bool, Error?, UIImage?) -> Void

class DataManager: NSObject {
    
    var allDiary = [DiaryItem]()
    
    var foodImageArray = [UIImage]()
    
    // 宣告一個singleton物件
    static let shared: DataManager = DataManager()
    
    // 若不繼承NSObject會無法override
    private override init() {
        
    }
    
    // Firebase Database 資料路徑設定，創建一個子層叫Diary
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    let DIARY_DB_REF: DatabaseReference = Database.database().reference().child("Diary")
    
    // Firbase storage 圖片路徑設定，創建一個子層叫Diary
    let DIARY_STORAGE_REF: StorageReference = Storage.storage().reference().child("Diary")
    
    // MARK: -Firebase 上傳資料實作
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
                                            DiaryItem.DirayInfoKey.foodImageURL : imageURL,
                                            DiaryItem.DirayInfoKey.createTime : createTime,
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
    
    // MARK: -Firebase 下載資料實作
    func downloadFromFirebase(doneHandler: @escaping DoneHandler) {
        
        // 先透過Firebase的內建方法將資料按照時戳(1970年至今總秒數)，由大到小(由新到舊)排列
        let diaryQuery = DIARY_DB_REF.queryOrdered(byChild: DiaryItem.DirayInfoKey.timeStamp)
        // 去針對某一特定條件去設置一個觀察者，在這邊是針對.value(任何針對資料的改動)做監聽
        diaryQuery.observe(.value) { (snapshot) in
            
            // 注意，任何從Firebase上得到的資料都會是snapshot的型別，內容是資料在Firebase資料庫內的地址
            // 在這邊我們指定要撈出所有的資料
            for diary in snapshot.children.allObjects as! [DataSnapshot] {
                // 撈到資料後，讀取裡面的內容(.value)，由於Firebase透過JSON格式儲存資料，所以我們指定撈回來的資料為[String : Any]的字典形式
                let diaryData = diary.value as? [String : Any] ?? [:]
                // 確認有撈到資料後，將資料整包帶進allDiary內
                if let diaryPost = DiaryItem(diaryDataFromFirebase: diaryData) {
                    self.allDiary.append(diaryPost)
                }
            }

            if self.allDiary.count > 0 {
                // 將撈回來的資料按照時戳由大到小排列
                // 後面尾隨閉包的寫法我看不懂 by Rabo
                self.allDiary.sort(by: {$0.timeStamp > $1.timeStamp})
            }
            // 把得到的allDiary放到doneHandler去當作參數，並在實際呼叫時實作

            doneHandler(true, nil, self.allDiary)
        }
    }
    
    // MARK: -下載圖片功能實作
    func downloadImage(foodImageURLString: String, imageDoneHandler: @escaping ImageDoneHandler) {
        
        // 如果撈回來的資料內的imageURL為空白，就下載預設的圖片
        if foodImageURLString == "" {
            imageDoneHandler(true, nil, UIImage(named: "00.jpg")) // 待補預設照片
            return
        }
        
        if let imageURL = URL(string: foodImageURLString) {
            
            let downloadTask = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                
                // 由於不能再背景碰UI，所以將圖片的載入放到主執行緒來執行
                DispatchQueue.main.sync {
                    let foodImage = UIImage(data: data!)
                    imageDoneHandler(true, error, foodImage)
                }
            })
            downloadTask.resume()
        }
    }
    
    // MARK: -將下載的圖片放到圖片陣列中，準備給Flowlayout使用
    func appendImage(image: UIImage) {
        
        foodImageArray.append(image)
        print("目前Image的內容是：\(image)")
    }
    
}
