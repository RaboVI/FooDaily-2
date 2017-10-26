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
    let welcomeTitleText = ["簡單上手","精美ＵI","雲端儲存"]
    
    // welcomeDetailLabel上要顯示的文字
    let welcomeDetailText = [
        "擺脫繁雜的操作，從現在開始愛上紀錄。吃過的東西、想吃的東西，通通一鍵新增！！",
        "瀑布流顯示，賞心悅目。一點一滴累積只屬於你的美食照片牆！！",
        "無論何處，隨存隨取。美食每刻，伴你一生！！"]

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
