//
//  DiaryViewController.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/6.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
    
    // UI IBOutlet
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodImageViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var createDateLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var cancelBtnOl: UIButton!
    @IBOutlet weak var moreFunctionBtnOl: UIButton!
    @IBOutlet weak var moreContentBtnOl: UIButton!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var remarkTextView: UITextView!
    
    @IBOutlet weak var noteBgView: UIView!
    
    let dataManager = DataManager.shared
    
    var indexPath:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteLabel.text = "筆記"
        remarkLabel.text = "備註"
        
        // 匯入已經下載好的資料
        shopNameLabel.text = dataManager.allDiary[indexPath].shopName
        foodNameLabel.text = dataManager.allDiary[indexPath].foodName
        priceLabel.text = "$ " + dataManager.allDiary[indexPath].price
        createDateLabel.text = dataManager.allDiary[indexPath].createTime
        noteTextView.text = dataManager.allDiary[indexPath].noteText
        remarkTextView.text = dataManager.allDiary[indexPath].remarkText
        foodImageView.image = dataManager.foodImageArray[indexPath]
        setStar(starCount: dataManager.allDiary[indexPath].starCount)
        noteTextView.isEditable = false
        remarkTextView.isEditable = false
        
        
        // 細節美化設定
        shopNameLabel.font = UIFont(name: "GenRyuMinTW-Bold", size: 30)
        foodNameLabel.font = UIFont(name: "GenRyuMinTW-Bold", size: 25)
        createDateLabel.font = UIFont(name: "Akrobat-Bold", size: 20)
        priceLabel.font = UIFont(name: "Akrobat-Bold", size: 17)
        
        shopNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        foodNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        createDateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        priceLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        setShadow(item: shopNameLabel)
        setShadow(item: foodNameLabel)
        setShadow(item: lineView)
        setShadow(item: createDateLabel)
        setShadow(item: star1)
        setShadow(item: star2)
        setShadow(item: star3)
        setShadow(item: star4)
        setShadow(item: star5)
        setShadow(item: cancelBtnOl)
        setShadow(item: moreFunctionBtnOl)
        setShadow(item: moreContentBtnOl)
        
        shopNameLabel.changeWordSpace(space: 1)
        foodNameLabel.changeWordSpace(space: 1)
        priceLabel.changeWordSpace(space: 1.5)
        noteLabel.changeWordSpace(space: 1.5)
        remarkLabel.changeWordSpace(space: 1.5)
        
        
        // 照片遮色片設定
        guard let imageSize = foodImageView.image?.size else { return }
        let graphicsFrame = CGRect(origin: .zero, size: imageSize)
        
        
        let filterColor1 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let filterColor2 = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1).cgColor
        let filterColor3 = #colorLiteral(red: 0.2431372549, green: 0.2274509804, blue: 0.2235294118, alpha: 1).cgColor
        let filter = CAGradientLayer()
        filter.frame = graphicsFrame
        filter.colors = [filterColor1, filterColor2, filterColor3]
        filter.locations = [0.28, 0.75, 1]
        
        
        // 繪製漸層遮色片 image
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        filter.render(in: context)
        guard let filterImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        
        UIGraphicsEndImageContext()
        
        
        // 繪製照片與漸層遮色片色彩增值
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
        
        foodImageView.image?.draw(in: graphicsFrame, blendMode: .normal, alpha: 1)
        filterImage.draw(in: graphicsFrame, blendMode: .multiply, alpha: 1)
        guard let newCurrentImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        foodImageView.image = newCurrentImage
        
        UIGraphicsEndImageContext()
        
        
        
        let noteBgViewLayer = CAGradientLayer()
        noteBgViewLayer.frame = noteBgView.frame
        noteBgViewLayer.colors = [#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.2431372549, green: 0.2274509804, blue: 0.2235294118, alpha: 1)]
        noteBgViewLayer.locations = [0, 0.73]
        noteBgView.layer.addSublayer(noteBgViewLayer)
        
    }
    
    
    func setShadow(item: UIView) {
        item.layer.shadowOffset = CGSize(width: 0, height: 0)
        item.layer.shadowOpacity = 1
        item.layer.shadowRadius = 1
        item.layer.shadowColor = UIColor(red: 0/255.0,
                                         green: 0/255.0,
                                         blue: 0/255.0,
                                         alpha: 1.0).cgColor
    }
    
    
    func setStar(starCount: Int) {
        
        let star = [star1, star2, star3, star4, star5]
        
        for i in 0..<starCount {
            star[i]?.image = UIImage(named: "solidStar.png")
        }
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

    
    
    @IBAction func moreContentBtn(_ sender: Any) {
        
        if self.foodImageViewBottomConstraint.constant == 0 {
            self.foodImageViewBottomConstraint.constant = self.noteBgView.frame.height
            let angle = 180 * CGFloat.pi / 180
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.moreContentBtnOl.transform = CGAffineTransform(rotationAngle: angle)
                            self.view.layoutIfNeeded()
            }) { (_) in
                return
            }
            
            
        } else {
            
            self.foodImageViewBottomConstraint.constant = 0
            let angle = -(360 * CGFloat.pi / 180)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.moreContentBtnOl.transform = CGAffineTransform(rotationAngle: angle)
                            self.view.layoutIfNeeded()
            }) { (_) in
                return
            }
        
        }
        
        
    }
    
    
    // Cancel != cancol
    @IBAction func cancolBtn(_ sender: Any) {
        
        if self.foodImageViewBottomConstraint.constant != 0 {
            
            self.foodImageViewBottomConstraint.constant = 0
            let angle = -(360 * CGFloat.pi / 180)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            self.moreContentBtnOl.transform = CGAffineTransform(rotationAngle: angle)
                            self.view.layoutIfNeeded()
            }) { (_) in
                self.dismiss(animated: true, completion: nil)
                return
            }
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func moreFunctionBtn(_ sender: Any) {
    }
    
    
    
}
