//
//  AddWantToEatViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class AddWantToEatViewController: UIViewController {
    
    @IBOutlet weak var addWantToEatCollectionView: UICollectionView!
    
    let wantToEatReload = "wantToEatReload"
    
    var cellCount = 1
    var cellWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
