//
//  WantToEatContentViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/17.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class WantToEatContentViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var remarkTextView: UITextView!
    
    @IBOutlet weak var cancelBtnOl: UIButton!
    @IBOutlet weak var cancelBtnTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelBtnTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var toCreateNewDiaryBtnOl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // UI 細節調整
        
        let bgBlurEffect = UIBlurEffect(style: .light)
        let bgBlurView = UIVisualEffectView(effect: bgBlurEffect)
        bgBlurView.frame.size = view.frame.size
        view.insertSubview(bgBlurView, at: 0)
        
        // bgView
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgView.frame
        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
        self.view.insertSubview(blurView, belowSubview: bgView)
        bgView.backgroundColor = UIColor.clear
        
        cancelBtnTopConstraint.constant = -(cancelBtnOl.frame.height / 2)
        cancelBtnTrailingConstraint.constant = -(cancelBtnOl.frame.width / 2)
        
        setShadow(item: blurView)
        setShadow(item: cancelBtnOl)
        setShadow(item: toCreateNewDiaryBtnOl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setShadow(item: UIView) {
    item.layer.shadowOffset = CGSize(width: 1, height: 1)
    item.layer.shadowOpacity = 0.2
    item.layer.shadowRadius = 3.5
    item.layer.shadowColor = UIColor(red: 44.0/255.0,
                                     green: 62.0/255.0,
                                     blue: 80.0/255.0,
                                     alpha: 1.0).cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func toCreateNewDiaryBtn(_ sender: Any) {
    }
    
    @IBAction func cancalBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
