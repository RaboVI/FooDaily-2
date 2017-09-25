//
//  MemberProfiolePage.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase

class MemberProfiolePage: UIViewController {

    @IBOutlet weak var memberProfileImage: UIImageView!
    
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        
        if let currentUser = Auth.auth().currentUser {
            nameLabel.text = currentUser.displayName
        }
        
        // Do any additional setup after loading the view.
        memberProfileImage.layer.borderColor = UIColor.white.cgColor
        memberProfileImage.layer.borderWidth = 2
        memberProfileImage.layer.cornerRadius = memberProfileImage.frame.width / 2
        memberProfileImage.layer.shadowColor = UIColor.darkGray.cgColor
        memberProfileImage.layer.shadowOffset = CGSize(width: 5, height: 3)
        memberProfileImage.layer.shadowOpacity = 0.8
        memberProfileImage.layer.shouldRasterize = true
        memberProfileImage.clipsToBounds = true
        
        signOutBtn.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 設定登出按鈕
    @IBAction func signOutBtnDidPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            let alertController = UIAlertController(title: "Logout Error.", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // 呈現歡迎畫面
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
            
        }
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
