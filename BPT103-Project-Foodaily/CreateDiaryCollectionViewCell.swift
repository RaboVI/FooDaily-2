//
//  CreateDiaryCollectionViewCell.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/9/28.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class CreateDiaryCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var createDiaryScrollView: UIScrollView!
    @IBOutlet weak var createDiaryPageControl: UIPageControl!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var scrollViewBgview: UIView!
    @IBOutlet weak var cameraBtnOL: UIButton!
    @IBOutlet weak var foodNameField: UITextField! //upload
    @IBOutlet weak var priceField: UITextField! //upload
    @IBOutlet weak var star01BtnOL: UIButton!
    @IBOutlet weak var star02BtnOL: UIButton!
    @IBOutlet weak var star03BtnOL: UIButton!
    @IBOutlet weak var star04BtnOL: UIButton!
    @IBOutlet weak var star05BtnOL: UIButton!
    @IBOutlet weak var noteTextView: UITextView! //upload，character<50
    @IBOutlet weak var noteTextViewBgView: UIView!
    
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var remarkTextViewBgView: UIView!
    @IBOutlet weak var remarkTextView: UITextView! //upload
    @IBOutlet weak var remarkTextViewWidth: NSLayoutConstraint!
    
    /// scrollView 中 內縮間距
    let scrollViewInsidePadding: CGFloat = 14
    
    /// 物件之間的距離
    let itemSpacing: CGFloat = 24
    
    let noteTextViewPlaceholder = "請輸入 50 字內之筆記..."
    
    var starBtnArray = [UIButton]()
    
    var delegate: UIViewController?
    
    var foodImage: UIImage? //upload
    
    var starCount: Int? //upload
    
    var userName: String? //upload
    
    override func awakeFromNib() {
        
        createDiaryScrollView.delegate = self
        
        // MARK: - Cell 內物件微調
        let scrollViewBgWidth = scrollViewBgview.frame.width
        // 因為疑似無法對齊 scrollView ，所以此處手動調整
        let newFNFWidth = scrollViewBgWidth / 2 - scrollViewInsidePadding * 2 - cameraBtnOL.frame.width - itemSpacing
        let FNFWidthConstraint = NSLayoutConstraint(item: foodNameField,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: newFNFWidth)
        foodNameField.addConstraint(FNFWidthConstraint)
        
        let newRemarkLabelWidth = scrollViewBgWidth / 2 - scrollViewInsidePadding
        let remarkLabelWidthConstraint = NSLayoutConstraint(item: remarkLabel,
                                                            attribute: .width,
                                                            relatedBy: .equal,
                                                            toItem: nil,
                                                            attribute: .notAnAttribute,
                                                            multiplier: 1.0,
                                                            constant: newRemarkLabelWidth)
        remarkLabel.addConstraint(remarkLabelWidthConstraint)
        
        remarkTextViewWidth.constant = scrollViewBgWidth / 2 - scrollViewInsidePadding * 2
        
        
        // UI 細節調整
        // bgView
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bgView.frame
        blurView.layer.cornerRadius = 15
        blurView.layer.shadowOffset = CGSize(width: 1, height: 1)
        blurView.layer.shadowOpacity = 0.2
        blurView.layer.shadowRadius = 3.5
        blurView.layer.shadowColor = UIColor(red: 44.0/255.0,
                                             green: 62.0/255.0,
                                             blue: 80.0/255.0,
                                             alpha: 1.0).cgColor
        blurView.clipsToBounds = true
        self.insertSubview(blurView, at: 0)
        bgView.backgroundColor = UIColor.clear
        
        // noteTextViewBgView
        noteTextViewBgView.layer.cornerRadius = 7.5
        noteTextViewBgView.clipsToBounds = true
        noteTextViewBgView.layer.borderColor = #colorLiteral(red: 0.6549019608, green: 0.6549019608, blue: 0.6549019608, alpha: 1)
        noteTextViewBgView.layer.borderWidth = 1.0
        
        // remarkTextViewBgView
        remarkTextViewBgView.layer.cornerRadius = 7.5
        remarkTextViewBgView.clipsToBounds = true
        remarkTextViewBgView.layer.borderColor = #colorLiteral(red: 0.6549019608, green: 0.6549019608, blue: 0.6549019608, alpha: 1)
        remarkTextViewBgView.layer.borderWidth = 1.0
        
        // noteTextView placeholder
        noteTextView.delegate = self
        noteTextView.text = noteTextViewPlaceholder
        noteTextView.textColor = UIColor.lightGray
        
        // 字型設定
//        foodNameField.font = UIFont(name: "GenRyuMinTW-Regular", size: 14)
//        priceField.font = UIFont(name: "GenRyuMinTW-Regular", size: 12)
//        noteTextView.font = UIFont(name: "GenRyuMinTW-Regular", size: 12)
//        remarkLabel.font = UIFont(name: "GenRyuMinTW-Regular", size: 14)
//        remarkTextView.font = UIFont(name: "GenRyuMinTW-Regular", size: 12)
        foodNameField.font = UIFont.systemFont(ofSize: 14)
        priceField.font = UIFont.systemFont(ofSize: 12)
        noteTextView.font = UIFont.systemFont(ofSize: 12)
        remarkLabel.font = UIFont.systemFont(ofSize: 14)
        remarkTextView.font = UIFont.systemFont(ofSize: 12)
        
        
        createDiaryPageControl.numberOfPages = 2
        createDiaryPageControl.currentPage = 0
        
        createDiaryScrollView.isPagingEnabled = true
        createDiaryScrollView.showsHorizontalScrollIndicator = false
        createDiaryScrollView.showsVerticalScrollIndicator = false
//        createDiaryScrollView.scrollsToTop = false
//        createDiaryScrollView.delegate = self
        
        starBtnArray = [star01BtnOL,
                        star02BtnOL,
                        star03BtnOL,
                        star04BtnOL,
                        star05BtnOL]
        
    }
    
    
    // MARK: - noteTextView placeholder.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteTextView.textColor == UIColor.lightGray {
            noteTextView.text = nil
            noteTextView.textColor = UIColor.darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextView.text.isEmpty {
            noteTextView.text = noteTextViewPlaceholder
            noteTextView.textColor = UIColor.lightGray
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let width = bgView.frame.size.width
        let contentX = scrollView.contentOffset.x + scrollView.frame.size.width
        let currentPage = Int(contentX / scrollView.frame.size.width - 1)
        
        createDiaryPageControl.currentPage = currentPage
    }
    
    
    @IBAction func Star01Btn(_ sender: Any) {
        starCount = 1
        setStar(starCount: starCount!)
    }
    
    @IBAction func Star02Btn(_ sender: Any) {
        starCount = 2
        setStar(starCount: starCount!)
    }
    
    @IBAction func Star03Btn(_ sender: Any) {
        starCount = 3
        setStar(starCount: starCount!)
    }
    
    @IBAction func Star04Btn(_ sender: Any) {
        starCount = 4
        setStar(starCount: starCount!)
    }
    
    @IBAction func Star05Btn(_ sender: Any) {
        starCount = 5
        setStar(starCount: starCount!)
    }
    
    func setStar(starCount: Int) {
        for star in starBtnArray {
            star.setImage(UIImage(named: "hollowStar.png"),
                          for: .normal)
        }
        for i in 0..<starCount {
            starBtnArray[i].setImage(UIImage(named: "solidStar.png"),
                                     for: .normal)
        }
    }
    
    
    
    // 取用相機拍照或從相簿裡取用照片
    @IBAction func cameraBtn(_ sender: Any) {
        // 產生一個UIImagePickerController的實體
        let imagePickerController = UIImagePickerController()
        // 讓imagePickerController的Delegate指定為viewController
        imagePickerController.delegate = self
        
        // 創建一個警告視窗表單
        let alertControllerSheet = UIAlertController(title: "相片來源", message: "使用相機或相簿", preferredStyle: .actionSheet)
        // 創建表單上的按鈕，取用相機
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertaction: UIAlertAction) in
            // 判斷相機是否可以使用，模擬器無法運行相機
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // 決定imagePickerController要使用的功能，相機功能
                imagePickerController.sourceType = .camera
//                self.present(imagePickerController, animated: true, completion: nil)
                self.delegate?.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("沒有偵測到相機")
            }
        }
        // 創建表單上的按鈕，取用相簿
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertaction:UIAlertAction) in
            // 決定imagePickerController要使用的功能，相簿功能
            imagePickerController.sourceType = .photoLibrary
            self.delegate?.present(imagePickerController, animated: true, completion: nil)
        }
        // 取消按鈕
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // 將按鈕新增到警告視窗表單
        alertControllerSheet.addAction(cameraAction)
        alertControllerSheet.addAction(libraryAction)
        alertControllerSheet.addAction(cancelAction)
        
        // 呈現警告視窗
        delegate?.present(alertControllerSheet, animated: true, completion: nil)
    }
    
    /// 當選取完圖片時要執行的動作
    // 來自UIImagePickerControllerDelegate的optional method.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // 讓photoImageView呈現剛剛選取的照片
            cameraBtnOL.contentMode = .scaleAspectFill
            cameraBtnOL.setImage(image, for: .normal)
            foodImage = image
           
        }
        // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
//        uniqueString = UUID().uuidString
        
        // 選取完畢，退出imagePickerController
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 當取消選取時要做的動作
    // 來自UIImagePickerControllerDelegate的optional method.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
