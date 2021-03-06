//
//  MemberProfiolePage.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class MemberProfiolePage: UIViewController {

    @IBOutlet weak var memberProfileImage: UIImageView!
    
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        
        if let currentUser = Auth.auth().currentUser {
            nameLabel.text = currentUser.displayName
            
            print(currentUser.photoURL ?? "沒有抓到圖片喔！")
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
        
        signOutBtn.layer.cornerRadius = 20
        
        // 新建一個leftBarButtonItem
        let backBtn = UIBarButtonItem.init(image: UIImage(named: "back.png"), style: .plain, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem = backBtn
        
    }
    
    // Pop回上一頁
    @objc func pop() {
        
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 設定登出按鈕
    @IBAction func signOutBtnDidPressed(_ sender: UIButton) {
        do {
            // 判斷使用者目前的登陸方法，如果是Google，則調用GIDSignIn中的SignOut讓使用者登出。
            // 注意，透過此方法每次使用者都要輸入密碼來驗證。
            if let providerData = Auth.auth().currentUser?.providerData {
                let userInfo = providerData[0]
                
                switch userInfo.providerID {
                case "google.com":
                    GIDSignIn.sharedInstance().signOut()

                case "facebook.com":
                    let  manager = FBSDKLoginManager()
                    manager.logOut()
                    FBSDKAccessToken.setCurrent(nil)
                    FBSDKProfile.setCurrent(nil)
                    
                default:
                    break
                }
            }
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
