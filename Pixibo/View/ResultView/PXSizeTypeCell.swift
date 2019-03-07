//
//  PXSizeTypeCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/29/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXSizeTypeCell: UICollectionViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUI(selectedVal: fys) {
        if selectedVal.recommended == 0 {
            sizeLabel.textColor = UIColor.brownGrey
        }else {
            sizeLabel.textColor = UIColor.black
        }
        sizeLabel.text = PXUtility.getConvertedSizeString(size: selectedVal.size ?? "")
    }
}
