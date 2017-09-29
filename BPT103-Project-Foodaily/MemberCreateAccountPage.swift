//
//  MemberCreateAccountPage.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit
import Firebase

class MemberCreateAccountPage: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        signUpBtn.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 回到導覽頁
    @IBAction func backToMemberSignInAndOutPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 設定透過Email註冊FooDaily帳號
    @IBAction func signUpBtnDidPressed(_ sender: UIButton) {
        
        // 輸入驗證
        guard let name = nameTextField.text, name != "",
            let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != ""
            
        else {
                
                let alertController = UIAlertController(title: "Registraion Error.", message: "Please make sure you provide your name, email address and password to complete the registeration.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // 在 Firebase 註冊使用者帳號
        Auth.auth().createUser(withEmail: emailAddress, password: password) { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Registration Error.", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // 儲存使用者的名稱
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Faild to change the display name: \(error.localizedDescription)")
                    }
                })
            }
            
            // 解除鍵盤
            self.view.endEditing(true)
            
            // 傳送認證信
            user?.sendEmailVerification(completion: nil)
            
            let alertController = UIAlertController(title: "Email Verification", message: "We've just sent a cofirmation email to your eamil address. Please check your inbox and click the verification lin k in that email to complete the sign up.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                // Dismiss the current view controller
                self.dismiss(animated: true, completion: nil    )
            })
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            
            //            // 呈現主視窗
            //            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            //                UIApplication.shared.keyWindow?.rootViewController = viewController
            //                self.dismiss(animated: true, completion: nil)
            //            }
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
