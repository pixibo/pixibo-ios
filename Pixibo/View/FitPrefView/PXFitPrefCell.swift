//
//  PXFitPrefCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/28/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
protocol PXFitPrefCellDelegate : class {
    func selectedFitPref(type: PXConstant.firPrefType)
}


class PXFitPrefCell: UITableViewCell {

    @IBOutlet var fitPrefButton: [PXTagView]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var cellType: PXConstant.cellType = .Unknown
    var delegate: PXFitPrefCellDelegate?
    var selectedType = PXConstant.firPrefType.PXRegular
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateDescriptionLabel(tag: Int) {
        switch (tag,cellType) {
        case (100,.PXBodyFitPref):
            selectedType = .PXTight
            descriptionLabel.text = "Fits tighter than intended."
        case (200,.PXBodyFitPref):
            selectedType = .PXRegular
            descriptionLabel.text = "Fits exactly as intended."
        case (300,.PXBodyFitPref):
            selectedType = .PXLoose
            descriptionLabel.text = "Fits looser than intended."
        case (100,.PXBodySizeResult):
            descriptionLabel.text = "Relazed Fit"
        case (200,.PXBodySizeResult):
            descriptionLabel.text = "Too Loose"
        case (300,.PXBodySizeResult):
            descriptionLabel.text = "Too Loose"
        default:
            break
        }
    }
    
    func setUI() {
        switch cellType {
        case .PXBodySizeResult:
            titleLabel.text = "SEE HOW IT FITS YOU"
            for button in fitPrefButton {
                if button.tag == 100 {
                    button.setTitle("TIGHT FIT", for: .normal)
                } else if button.tag == 200 {
                    button.setTitle("REGULAR FIT", for: .normal)
                } else if button.tag == 300 {
                    button.setTitle("LOOSE FIT", for: .normal)
                }
            }
        case .PXBodyFitPref:
            titleLabel.text = "WHAT IS YOUR FIT PREFERENCE?"
            for button in fitPrefButton {
                if button.tag == 100 {
                    button.setTitle("TIGHT FIT", for: .normal)
                } else if button.tag == 200 {
                    button.setTitle("REGULAR FIT", for: .normal)
                } else if button.tag == 300 {
                    button.setTitle("LOOSE FIT", for: .normal)
                }
            }
        default:
            break
        }
    }
    
    @IBAction func fitPreferenceClicked(_ sender: UIButton) {
        for button in fitPrefButton {
            if button.tag == sender.tag {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        updateDescriptionLabel(tag: sender.tag)
        delegate?.selectedFitPref(type: selectedType)
    }
    
}
