//
//  UINavigationController+Transparent.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the navigation bar transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.white
        // 設定NavigationBar上title的文字字體、大小及顏色
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Rubik-Medium", size: 20)!,NSForegroundColorAttributeName: UIColor.white]
    }
}
