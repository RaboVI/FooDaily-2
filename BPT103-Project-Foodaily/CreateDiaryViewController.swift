//
//  CreateDiaryViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/29.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class CreateDiaryViewController: UIViewController {
    
    @IBOutlet weak var createDiaryCollectionView: CreateDiaryCollectionView!
    
    var cellCount = 1
    var cellWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
    
    
    @IBAction func saveNewDiaryBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            print(indexPath)
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
