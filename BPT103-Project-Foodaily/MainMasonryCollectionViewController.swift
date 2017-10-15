//
//  MainMasonryCollectionViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainMasonryCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: MainMasonryFlowLayout!
    @IBOutlet var MMCollectionView: UICollectionView!
    
    let dataManager = FakeDataManager.shared
    
    let newDataManager = DataManager.shared
    
    let createNewDairyBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
            // 嘗試抓取Firebase資料，若成功則顯示在Console上
            newDataManager.downloadFromFirebase { (success, error, result) in
                
                guard success == true else {
                    print("獲取Firebase資料失敗或中斷")
                    return
                }
                
                guard let allDiary = result else {
                    print("沒有得到Database的資料內容")
                    return
                }
                
                allDiary.forEach({ (everyDiary) in
                    
                    print("-----------------------------------")
                    print("餐廳名稱： \(everyDiary.shopName)")
                    print("餐點名稱： \(everyDiary.foodName)")
                    print("價格： \(everyDiary.price)")
                    print("評價： \(everyDiary.starCount)")
                    print("筆記： \(everyDiary.noteText)")
                    print("備註： \(everyDiary.remarkText)")
                    print("使用者： \(everyDiary.userName)")
                    print("記錄日期： \(everyDiary.createTime)")
                    print("時戳： \(everyDiary.timeStamp)")
                    print("照片URL： \(everyDiary.foodImageURL)")
                    
                    self.newDataManager.downloadImage(foodImageURLString: everyDiary.foodImageURL, imageDoneHandler: { (success, error, result) in
                        
                        guard let result = result else {
                            return
                        }
                        self.newDataManager.appendImage(image: result)
                    })
                })
            }

        
        self.title = "FooDaily"
        
        self.collectionView?.collectionViewLayout = flowLayout

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
        let createNewDairyBtnSize = CGSize(width: 60,
                                           height: 60)
        
        let createNewDairyBtnSpace: CGFloat = 20
        
        let createNewDairyBtnX = MMCollectionView.frame.midX - createNewDairyBtnSize.width / 2
        let createNewDairyBtnY = UIScreen.main.bounds.height - createNewDairyBtnSpace - createNewDairyBtnSize.height
        
        createNewDairyBtn.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.4509803922, blue: 0.3411764706, alpha: 1)
        
        createNewDairyBtn.setImage(UIImage(named: "plue.png"),
                                   for: .normal)
        
        createNewDairyBtn.frame = CGRect(x: createNewDairyBtnX,
                                         y: createNewDairyBtnY,
                                         width: createNewDairyBtnSize.width,
                                         height: createNewDairyBtnSize.height)
        
        createNewDairyBtn.layer.cornerRadius = createNewDairyBtnSize.width / 2
        
        createNewDairyBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        createNewDairyBtn.layer.shadowOpacity = 0.2
        createNewDairyBtn.layer.shadowRadius = 3.5
        createNewDairyBtn.layer.shadowColor = UIColor(red: 44.0/255.0,
                                                       green: 62.0/255.0,
                                                       blue: 80.0/255.0,
                                                       alpha: 1.0).cgColor
        
        createNewDairyBtn.addTarget(self, action: #selector(createNewDairy), for: .touchUpInside)
        
        self.view.addSubview(createNewDairyBtn)
        
    }
    
    
    
    
    @objc func createNewDairy() {
        
        let createDiaryStoryboard = UIStoryboard.init(name: "CreateDiary", bundle: .main)
        let vc = createDiaryStoryboard.instantiateViewController(withIdentifier: "CreateDiaryViewController")
        
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        print("")
        print("現在Section內共有： \(dataManager.dailyItem.count) 個items")
        return dataManager.dailyItem.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dailyItem = dataManager.dailyItem[indexPath.row]
        let width = (self.view.bounds.size.width - flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / 2
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainMasonryCollectionViewCell
    
        cell.setCellDetail(image: dailyItem.image,
                           shopName: dailyItem.shopName,
                           createDate: dailyItem.createDate,
                           starCount: dailyItem.starCount,
                           width: width)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    

}
