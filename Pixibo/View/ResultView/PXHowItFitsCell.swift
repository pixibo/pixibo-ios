//
//  PXHowItFitsCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/10/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXHowItFitsCell: UITableViewCell {

    @IBOutlet weak var bustTitle: UILabel!
    @IBOutlet weak var bustFitDetail: UILabel!
    @IBOutlet weak var waistTitle: UILabel!
    @IBOutlet weak var waistFitDetails: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var hipsFitDetails: UILabel!
    @IBOutlet weak var hipsTitle: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var expanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func expandButtonClicked(_ sender: Any) {
        
    }
    
    func updateUI(data: fys) {
//        if expanded {
//            heightConstraint.constant = 100
//        }else {
//            heightConstraint.constant = 0
//        }
        if let bustc = data.bustCode {
            setFitDescString(type: bustc, label: bustFitDetail)
        }
        if let waistc = data.waistCode {
            setFitDescString(type: waistc, label: waistFitDetails)
        }
        if let hipc = data.hipCode {
            setFitDescString(type: hipc, label: hipsFitDetails)
        }
        layoutSubviews()
        updateConstraints()
        
    }
    
    func setFitDescString(type: Int, label: UILabel) {
        
        switch type {
        case 0:
            label.text = "Not applicable"
            label.textColor = UIColor.brownGrey
        case 1:
            label.text = "Too Tight"
            label.textColor = UIColor.brownGrey
        case 2:
            label.text = "Snug Fit"
            label.textColor = UIColor.paleTeal
        case 3:
            label.text = "Ideal Fit"
            label.textColor = UIColor.paleTeal
        case 4:
            label.text = "Loose Fit"
            label.textColor = UIColor.paleTeal
        case 5:
            label.text = "Too Loose"
            label.textColor = UIColor.brownGrey
        default:
            break
        }
    }
}
