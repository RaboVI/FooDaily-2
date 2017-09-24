//
//  MemberSignInAndOutViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/25.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class MemberSignInAndOutViewController: UIViewController {

    @IBOutlet weak var signInWithEmailBtn: UIButton!
    @IBOutlet weak var signInWithFacebookBtn: UIButton!
    @IBOutlet weak var signInWithGoogleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInWithEmailBtn.layer.cornerRadius = 30
        signInWithEmailBtn.layer.borderColor = UIColor.white.cgColor
        signInWithEmailBtn.layer.borderWidth = 2
        signInWithFacebookBtn.layer.cornerRadius = 30
        signInWithGoogleBtn.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 設定透過EMAIL登陸
    @IBAction func signInWithEmailBtnDidPressed(_ sender: Any) {
        
    }
    
    // 設定透過FB登錄
    @IBAction func signInWithFacebookBtnDidPressed(_ sender: Any) {
        
    }
    
    // 設定透過Google登錄
    @IBAction func signInWithGoogleBtnDidPressed(_ sender: Any) {
        
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
