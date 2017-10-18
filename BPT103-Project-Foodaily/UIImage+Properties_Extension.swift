//
//  UIImage+Properties_Extension.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/10/17.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import Foundation
import UIKit

private var key = ""

extension UIImage {
    
    var url: String {
        
        get {
            return (objc_getAssociatedObject(self, &key) as? String)!
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
