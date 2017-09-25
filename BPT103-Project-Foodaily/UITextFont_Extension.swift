//
//  UITextFont_Extension.swift
//  0919_layerForTest
//
//  Created by Rabo Lu on 2017/9/19.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    // 改變行的間距
    func changeLineSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        guard let text = self.text else {
            NSLog("text is nil")
            return
        }
        let attributedString = NSMutableAttributedString.init(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text.characters.count)))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    // 改變字的間距
    func changeWordSpace(space: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        guard let text = self.text else {
            NSLog("text is nil")
            return
        }
        let attributedString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedStringKey.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text.characters.count)))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    // 同時改變行間距以及字間距
    func changeSpace(lineSpace: CGFloat, wordSpace: CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        guard let text = self.text else {
            NSLog("text is nil")
            return
        }
        let attributedString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedStringKey.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: (text.characters.count)))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}
