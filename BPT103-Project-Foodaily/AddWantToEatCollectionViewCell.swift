//
//  AddWantToEatCollectionViewCell.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class AddWantToEatCollectionViewCell: UICollectionViewCell, UITextViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var remarkBgView: UIView!
    @IBOutlet weak var remarkTextView: UITextView!
    
    let remarkTextViewPlaceholder = "請輸入備註..."
    
    var delegate: UIViewController?
    
    override func awakeFromNib() {
        
        // UI 細節調整
        // bgView
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgView.frame
        blurView.layer.cornerRadius = 15
        blurView.layer.shadowOffset = CGSize(width: 1, height: 1)
        blurView.layer.shadowOpacity = 0.9
        blurView.layer.shadowRadius = 3.5
        blurView.layer.shadowColor = UIColor(red: 44.0/255.0,
                                             green: 62.0/255.0,
                                             blue: 80.0/255.0,
                                             alpha: 1.0).cgColor
        blurView.clipsToBounds = true
        self.insertSubview(blurView, at: 0)
        bgView.backgroundColor = UIColor.clear
        
        // remarkBgView
        remarkBgView.layer.cornerRadius = 7.5
        remarkBgView.clipsToBounds = true
        remarkBgView.layer.borderColor = #colorLiteral(red: 0.6549019608, green: 0.6549019608, blue: 0.6549019608, alpha: 1)
        remarkBgView.layer.borderWidth = 1.0
        
        // remarkTextView placeholder
        remarkTextView.delegate = self
        remarkTextView.text = remarkTextViewPlaceholder
        remarkTextView.textColor = UIColor.lightGray
        
    }
    
    // MARK: - remarkTextView placeholder.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if remarkTextView.textColor == UIColor.lightGray {
            remarkTextView.text = nil
            remarkTextView.textColor = UIColor.darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if remarkTextView.text.isEmpty {
            remarkTextView.text = remarkTextViewPlaceholder
            remarkTextView.textColor = UIColor.lightGray
            
        }
    }
    
}
