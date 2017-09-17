//
//  PageViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Rabo Lu on 2017/9/15.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

    // 宣告一個變數並繼承PageViewControllerDelegate
    weak var pageDelegate: PageViewControllerDelegate?
    
    // 宣告一個計時器的變數
    var timer: Timer!
    
    // 宣告一個計時器的變數
    var index = 0
    
    // 將三個viewController包在一個陣列裡面，並指定各個viewController的Identifier
    lazy var vclist: [UIViewController] = {
        
        return [self.viewControllerInstance(name: "VC1"),
                self.viewControllerInstance(name: "VC2"),
                self.viewControllerInstance(name: "VC3")]
    }()
    
    // 阿中教的方法，我只知道大概意思跟storyboard?.instantiateViewController(withIdentifier: "vc1")意思相同
    private func viewControllerInstance(name: String) -> UIViewController {
        //"Main"是使用者自行取名
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注意，當有導覽點的時候，需要加入下方的程式碼。否則第一頁會是全黑的。
        setViewControllers([vclist[index]], direction: .forward, animated: true, completion: nil)
        
        // 將delegate及DataSource簽給PageViewController
        dataSource = self
        delegate = self
        
        // MARK: - 自動換頁的function
        // 設定一個計時器，每4秒執行#selector內的function
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(autoChangePageView), userInfo: nil, repeats: true)
        
        // 實作pageDelegate的方法，並把參數指定為vclist.count
        pageDelegate?.pageViewController(self, didUpdatePageCount: vclist.count)
    }
    
    // 有簽UIPageViewControllerDataSource就一定要有的方法，否則會報錯
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let manualIndex = vclist.index(of: viewController) else {
            return nil
        }
        self.index = Int(manualIndex)
        pageDelegate?.pageViewController(self, didUpdatePageIndex: self.index)
        
        let nextIndex = manualIndex + 1
        
        guard nextIndex < vclist.count else {
            return vclist.first
        }
        
        return vclist[nextIndex]
    }
    
    // 有簽UIPageViewControllerDataSource就一定要有的方法，否則會報錯
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let manualIndex = vclist.index(of: viewController) else {
            return nil
        }
        
        self.index = Int(manualIndex)
        pageDelegate?.pageViewController(self, didUpdatePageIndex: self.index)
        
        let previousIndex = manualIndex - 1
        
        guard previousIndex >= 0 else {
            return vclist.last
        }
        
        guard vclist.count > previousIndex else {
            return nil
        }
        
        print(self.index)
        return vclist[previousIndex]
    }
    
    // 設計一個function給timer內的#selector使用，內部的程式碼將負責換頁
    func autoChangePageView() {
        
        index += 1
        if index < self.vclist.count {
            setViewControllers([vclist[index]], direction: .forward, animated: true, completion: nil)
        }
        else {
            index = 0
            setViewControllers([vclist[index]], direction: .forward, animated: true, completion: nil)
        }
        pageDelegate?.pageViewController(self, didUpdatePageIndex: index)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

// 自行定義一個PageViewControllerDelegate
protocol PageViewControllerDelegate: class {
    
    // 當頁面總數改變時執行的method
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageCount count: Int)
    
    // 當index改變時執行的methoid
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageIndex index: Int)
}

