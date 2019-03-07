//
//  PXHeaderTitleCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXHeaderTitleCell: UITableViewHeaderFooterView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func updateUI(color: UIColor, title: String, textColor: UIColor = UIColor.black) {
        containerView.backgroundColor = color
        titleLabel.textColor = textColor
        titleLabel.text = title
        titleLabel.textAlignment = .center
    }
    

}
