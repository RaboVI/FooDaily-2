//
//  MemberProfiolePage.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class MemberProfiolePage: UIViewController {

    @IBOutlet weak var memberProfileImage: UIImageView!
    
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memberProfileImage.layer.cornerRadius = 100
        memberProfileImage.layer.shadowColor = UIColor.darkGray.cgColor
        memberProfileImage.layer.shadowOffset = CGSize(width: 5, height: 3)
        memberProfileImage.layer.shadowOpacity = 0.8
        memberProfileImage.layer.shouldRasterize = true
        
        signOutBtn.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 設定登出按鈕
    @IBAction func signOutBtnDidPressed(_ sender: Any) {
        
    }
    
    // 回到主畫面
    @IBAction func backToMainPageView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
