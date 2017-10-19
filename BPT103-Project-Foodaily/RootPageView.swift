//
//  RootPageView.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/15.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class RootPageView: UIViewController,PageViewControllerDelegate {
    
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var welcomeDetailLabel: UILabel!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    // 設立一個導覽點，會由PageViewController的Delegate傳回值來控制
    @IBOutlet weak var pageControl: UIPageControl!
    
    // welcomeTitleLabel上要顯示的文字
    let welcomeTitleText = ["壓力腦袋","壓力腦袋","壓力腦袋"]
    
    // welcomeDetailLabel上要顯示的文字
    let welcomeDetailText = [
        "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶",
        "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶",
        "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶"]

    // 準備一個頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            // 設置一個Delegate並把對象指定為RootPageView
            pageViewController.pageDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInBtn.layer.cornerRadius = 20
        signUpBtn.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
        welcomeDetailLabel.text = welcomeDetailText[0]
        
        detectAccessTokenAlreadyExist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 計算導覽點的數量
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    // 設定導覽點的位置
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        welcomeTitleLabel.text = welcomeTitleText[index]
        welcomeDetailLabel.text = welcomeDetailText[index]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //
    func detectAccessTokenAlreadyExist() {
        
        let firstLogin = false
        
        UserDefaults.standard.setValue(firstLogin, forKey: "firstLogin")
        
    }
}
