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
    
    // 設立一個導覽點，會由PageViewController的Delegate傳回值來控制
    @IBOutlet weak var pageControl: UIPageControl!
    
    // welcomeTitleLabel要顯示的文字
    let welcomeTitleText = ["1234","壓力腦袋","壓力腦袋"]
    
    // welcomeDetailLabel要顯示的文字
    let welcomeDetailText = [
        "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶",
         "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶",
         "原料回憶是以同時娛樂正確郵箱下載次數掌握簡介現金日誌，傳統想到介紹隨着後面好好戰爭上了達到您可以律師面對當中寂寞不以同時原料回憶"]

    //场景切换
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            //设置委托（当页面数量、索引改变时当前视图控制器能触发页控件的改变）
            pageViewController.pageDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        welcomeDetailLabel.text = welcomeDetailText[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 進入註冊頁面
    @IBAction func regeisterBTN(_ sender: Any) {
        
        
    }
    
    // 進入會員登錄頁面
    @IBAction func loginBTN(_ sender: Any) {
        
        
        
    }
    
    // 計算點點的數量
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    // 設定點點的位置
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

}
