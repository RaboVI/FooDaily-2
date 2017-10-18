//
//  UINavigationController+Transparent.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func customizeUIStyle() {
        // 改變BarButtonItem上文字的顏色
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Akrobat", size: 18)!, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.3490196078, alpha: 1)], for: UIControlState.normal)
    }
}

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Make the navigation bar transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        // 改變BarButtonItem上圖形的顏色
        self.navigationBar.tintColor = #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.3490196078, alpha: 1)
        // 設定NavigationBar上title的文字字體、大小及顏色
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Akrobat", size: 18)!,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.3490196078, alpha: 1)]
    }
}
