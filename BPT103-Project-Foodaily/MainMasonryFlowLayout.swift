//
//  MainMasonryFlowLayout.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/18.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class MainMasonryFlowLayout: UICollectionViewFlowLayout {
    
    let dataManager = DataManager.shared
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    var layoutItemSize = CGSize()
    
    override func prepare() {
        super.prepare()
        
        // 設定 section and cell 空間配置
        // section
        sectionInset.top        = 2.5
        sectionInset.left       = 2.5
        sectionInset.right      = 2.5
        
        // cell
        minimumLineSpacing      = 0
        minimumInteritemSpacing = 0
        
        // compute cell width
        guard let collectionViewWidth = collectionView?.bounds.size.width else { return }
        let cellWidth = (collectionViewWidth - sectionInset.left - sectionInset.right - minimumInteritemSpacing) / 2
        
        print("")
        print("瀑布流現在cell的寬度是：\(cellWidth)")
        
        computeAndSaveAttributes(cellWidth: cellWidth)
        
        itemSize = layoutItemSize
    }
    
    func computeAndSaveAttributes(cellWidth: CGFloat) {
        
        // 存放 attribute
        var attributes = [UICollectionViewLayoutAttributes]()
        
        // 物件編號記數器
        var row = 0
        
        // 用於記錄每個 cell 的高度
        var columnHeights = [CGFloat](repeating: sectionInset.top,
                                      count: 2)
        
        // 用於記錄每個 column 的 item 數量
        var columnCellCount = [Int](repeating: 0,
                                    count: 2)
        
        // 設定各個column 的 x 軸位置
        let columnX: [CGFloat] = [sectionInset.left,
                                  sectionInset.right + cellWidth + minimumInteritemSpacing]
        
        
        for image in dataManager.foodImageArray {
        
            // 建立一個 attribute 物件，並給予位置設定
            let indexPath = IndexPath.init(row: row,
                                           section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 找出最短的 column
            // sorted() => 自動排列，由小到大
            guard let minHeight = columnHeights.sorted().first else { return }
            // 取得最短 column 的 index
            guard let minHeightColume = columnHeights.index(of: minHeight) else { return }
            
            // 在最短的 column 上增加物件
            // 並在 columnCellCount 做記錄
            columnCellCount[minHeightColume] += 1
            // 設定 cell 的 x y 軸位置
            let cellX = columnX[minHeightColume]
            let cellY = minHeight
            
            /*
            // 依比例計算出調整後的高度  originHeight * finalWidth / originWidth
            let cellHeight = item.size.height * cellWidth / item.size.width
            */
            
            print(" 現在Flowlayout內使用的Image分別是：\(image)")
            let cellSize = MainMasonryCollectionViewCell.computeCellSize(image: image,
                                                                         width: cellWidth)
            
            // 設定 attribute 的 frame，並加入到 attributes 中
            attribute.frame = CGRect(x: cellX,
                                     y: cellY,
                                     width: cellSize.width,
                                     height: cellSize.height)
            
            attributes.append(attribute)
            
            // 記錄增加物件後的 column 高度
            columnHeights[minHeightColume] += cellSize.height + minimumLineSpacing
            
            row += 1
            
        }
        
        let maxHeight = columnHeights.sorted().last!
        
        var defaultColumnCount: CGFloat = CGFloat(dataManager.allDiary.count / 2)
        
        if dataManager.allDiary.count % 2 == 1 {
            defaultColumnCount += 1
        }
        
        let itemHeight = (maxHeight - minimumLineSpacing * defaultColumnCount) / defaultColumnCount
        let cellSize = CGSize(width: cellWidth, height: itemHeight)
        
        layoutAttributes = attributes
        layoutItemSize = cellSize
        
    }
    
    // 個人理解為： 將設定好的每個 cell 格式，並將之送回
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // ...
        return layoutAttributes
    }
}
