//
//  CreateDiaryViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/29.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase

class CreateDiaryViewController: UIViewController {
    
    @IBOutlet weak var createDiaryCollectionView: CreateDiaryCollectionView!
    
    let dataManager = DataManager.shared
    
    var userName: String?
    
    var cellCount = 1
    var cellWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let currentUser = Auth.auth().currentUser {
            userName = currentUser.displayName
        }
        
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = view.frame.size
        view.insertSubview(blurView, at: 0)
        
//    createDiaryCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        
        createDiaryCollectionView.showsVerticalScrollIndicator = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // 按下按鈕後上傳
    @IBAction func saveNewDiaryBtn(_ sender: Any) {
        
        let createDiaryCellHeader = createDiaryCollectionView.supplementaryView(forElementKind: "UICollectionElementKindSectionHeader", at: IndexPath(row: 0, section: 0)) as! CreateDiaryHeaderCollectionReusableView
        
        for i in 0..<cellCount {
            let indexPath = IndexPath(row: i, section: 0)
            let createDiaryCell = createDiaryCollectionView.cellForItem(at: indexPath) as! CreateDiaryCollectionViewCell
        
            guard let currentUser = userName,
                let shopName = createDiaryCellHeader.shopNameField.text,
                let foodName = createDiaryCell.foodNameField.text,
                let price = createDiaryCell.priceField.text,
                let noteText = createDiaryCell.noteTextView.text,
                let remarkText = createDiaryCell.remarkTextView.text,
                let starCount = createDiaryCell.starCount
            else{
               return
            }
            
            if let foodImage = createDiaryCell.foodImage {
                dataManager.uploadToFirebase(shopName: shopName, foodName: foodName, price: price, starCount: starCount, noteText: noteText, remarkText: remarkText, foodImage: foodImage, userName: currentUser)
                
                NSLog("\n 使用者名稱：\(currentUser) 餐廳名稱：\(shopName)\n 餐點名稱：\(foodName)\n 餐點價格：\(price)\n 評價：\(starCount)\n 筆記：\(noteText)\n 備註：\(remarkText)")
                
                self.dismiss(animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "您還沒有選用相片喔！", message: "或使用FooDaily的預設照片。", preferredStyle: .alert)
                
                let tempImageAction = UIAlertAction(title: "預設相片", style: .default, handler: { (UIAlertAciotn:UIAlertAction) in
                    
                    if let tempFoodImage = UIImage(named: "PageView-1.jpg") {
                        self.dataManager.uploadToFirebase(shopName: shopName, foodName: foodName, price: price, starCount: starCount, noteText: noteText, remarkText: remarkText, foodImage: tempFoodImage, userName: currentUser)
                        
                        NSLog("\n 使用者名稱：\(currentUser) 餐廳名稱：\(shopName)\n 餐點名稱：\(foodName)\n 餐點價格：\(price)\n 評價：\(starCount)\n 筆記：\(noteText)\n 備註：\(remarkText)")
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alertController.addAction(tempImageAction)
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateDiaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CreateDiaryCollectionViewCell
        cell.delegate = self
        cellWidth = cell.frame.width
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
//            print(UICollectionElementKindSectionHeader)
            var reusableView = CreateDiaryHeaderCollectionReusableView()
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CreateDiaryHeaderCollectionReusableView
            
//            reusableView.headerWidth = createDiaryCollectionView.frame.size.width
            
            reusableView.setHeader(width: cellWidth)
            
            return reusableView
            
        } else if kind == UICollectionElementKindSectionFooter {
            var reusableView = CreateDiaryFooterCollectionReusableView()
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! CreateDiaryFooterCollectionReusableView
            
            reusableView.addCellBtnOL.addTarget(self, action: #selector(addCell), for: .touchUpInside)
            
            return reusableView
            
        } else {
            let reusebleView = UICollectionReusableView()
            
            return reusebleView
        }
    }
    
    @objc func addCell() {
        
        let newIndexPath = IndexPath(row: cellCount, section: 0)
        cellCount += 1
        self.createDiaryCollectionView.performBatchUpdates({
            self.createDiaryCollectionView.insertItems(at: [newIndexPath])
            
        }, completion: nil)
        
    }
}
