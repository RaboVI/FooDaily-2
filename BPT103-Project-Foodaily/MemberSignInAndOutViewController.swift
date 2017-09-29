//
//  MemberSignInAndOutViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class MemberSignInAndOutViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {

    @IBOutlet weak var signInWithEmailBtn: UIButton!
    @IBOutlet weak var signInWithFacebookBtn: UIButton!
    @IBOutlet weak var signInWithGoogleBtn: UIButton!
    @IBOutlet weak var signUpWithEmailBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        
        // 指定GIDSignIn以及GIDSignInUI兩者的Delegate為自身
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view.
        signInWithEmailBtn.layer.cornerRadius = 30
        signInWithEmailBtn.layer.borderColor = UIColor.white.cgColor
        signInWithEmailBtn.layer.borderWidth = 2
        signInWithFacebookBtn.layer.cornerRadius = 30
        signInWithGoogleBtn.layer.cornerRadius = 30
        signUpWithEmailBtn.layer.cornerRadius = 30
        signUpWithEmailBtn.layer.borderColor = UIColor.white.cgColor
        signUpWithEmailBtn.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 設定透過FB登錄
    @IBAction func signInWithFacebookBtnDidPressed(_ sender: UIButton) {
        
        let fbLoginManager = FBSDKLoginManager()
        
        /// 注意：這邊有withReadPermissions跟withPublicPermissions
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) in
            
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            // 將FBSDKAccessToken轉換成Firebase憑證
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // 呼叫 Firebase APIs來執行登入
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login error.", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // 呈現主視窗
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
        }
    }
    
    // 設定透過Google登錄
    @IBAction func signInWithGoogleBtnDidPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // 實作兩個GIDsignInDelegate的Method，供之後Google登錄按鈕使用
    // 此方法會在完成登陸時被呼叫
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // 呈現主視窗
//            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//                self.dismiss(animated: true, completion: nil)
//            }
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                    self.navigationController?.present(viewController, animated: true, completion: nil)
            }

        }
    }
    
    // 此方法會在使用者斷線時被呼叫
    // 目前還沒有要在斷線時執行的動作，故先留白。
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
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
