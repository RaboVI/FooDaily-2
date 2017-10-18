//
//  WantToEatTableViewCell.swift
//  BPT103-Project-Foodaily
//
//  Created by Hong Shih on 2017/10/16.
//  Copyright © 2017年 RaboLu. All rights reserved.
//

import UIKit

class WantToEatTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let color = #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.3490196078, alpha: 1)
        bgView.layer.cornerRadius = bgView.frame.height / 2
        bgView.layer.borderColor = color.cgColor
        bgView.layer.borderWidth = 1
        bgView.clipsToBounds = true
        bgView.backgroundColor = UIColor.clear
        
        lineView.backgroundColor = color
        
        titleLabel.textColor = color
        remarkLabel.textColor = color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
