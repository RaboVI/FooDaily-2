//
//  AddWantToEatViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase

class AddWantToEatViewController: UIViewController {
    
    @IBOutlet weak var addWantToEatCollectionView: UICollectionView!
    
    let wantToEatReload = "wantToEatReload"
    
    let dataManger = DataManager.shared
    
    var cellCount = 1
    var cellWidth: CGFloat = 0
    
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            userName = currentUser.displayName
        }
        
        // Do any additional setup after loading the view.
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = view.frame.size
        view.insertSubview(blurView, at: 0)
        
        addWantToEatCollectionView.showsVerticalScrollIndicator = false
        
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
    
    
    @IBAction func saveNewWantToEatBtn(_ sender: Any) {
        
        let createWTECellHeader = addWantToEatCollectionView.supplementaryView(forElementKind: "UICollectionElementKindSectionHeader", at: IndexPath(row: 0, section: 0)) as! AddWantToEatHeaderCollectionReusableView
        
        for i in 0..<cellCount {
            let indexPath = IndexPath(row: i, section: 0)
            let createWTECell = addWantToEatCollectionView.cellForItem(at: indexPath) as! AddWantToEatCollectionViewCell
            
            guard let currentUser = userName,
                let shopName = createWTECellHeader.shopNameField.text,
                let remarkText = createWTECell.remarkTextView.text
            else{
                return
            }
            
            dataManger.uploadWteDataToFirebase(shopName: shopName, remarkText: remarkText, userName: currentUser)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(wantToEatReload), object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}




extension AddWantToEatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AddWantToEatCollectionViewCell
        cell.delegate = self
        cellWidth = cell.frame.width
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            //            print(UICollectionElementKindSectionHeader)
            var reusableView = AddWantToEatHeaderCollectionReusableView()
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! AddWantToEatHeaderCollectionReusableView
            
            
            //            reusableView.headerWidth = addWantToEatCollectionView.frame.size.width
            
            reusableView.setHeader(width: cellWidth)
            
            return reusableView
            
        } else if kind == UICollectionElementKindSectionFooter {
            var reusableView = AddWantToEatFooterCollectionReusableView()
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! AddWantToEatFooterCollectionReusableView
            
            reusableView.addCellBtnOl.addTarget(self, action: #selector(addCell), for: .touchUpInside)
            
            return reusableView
            
        } else {
            let reusebleView = UICollectionReusableView()
            
            return reusebleView
        }
    }
    
    @objc func addCell() {
        
        let newIndexPath = IndexPath(row: cellCount, section: 0)
        cellCount += 1
        self.addWantToEatCollectionView.performBatchUpdates({
            self.addWantToEatCollectionView.insertItems(at: [newIndexPath])
            
        }, completion: nil)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
