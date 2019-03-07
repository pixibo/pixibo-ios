//
//  PXFitConfidenceNewCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/3/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXFitConfidenceNewCell: UITableViewCell {
    @IBOutlet var starsButton: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for button in starsButton {
            switch button.tag {
            case 100:
                button.setImage(UIImage(named: "terribleDisable"), for: .normal)
                button.setImage(UIImage(named: "terribleActive"), for: .selected)
            case 200:
                button.setImage(UIImage(named: "veryBadDisable"), for: .normal)
                button.setImage(UIImage(named: "veryBadActive"), for: .selected)
            case 300:
                button.setImage(UIImage(named: "okayDisable"), for: .normal)
                button.setImage(UIImage(named: "okayActive"), for: .selected)
            case 400:
                button.setImage(UIImage(named: "loveItDisable"), for: .normal)
                button.setImage(UIImage(named: "loveItActive"), for: .selected)
            case 500:
                button.setImage(UIImage(named: "amazingDisable"), for: .normal)
                button.setImage(UIImage(named: "amazingActive"), for: .selected)
            default:
                break
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(selected: Int) {
        let button = UIButton()
        button.tag = selected * 100
        fitPreferenceClicked(button)
    }
    
    @IBAction func fitPreferenceClicked(_ sender: UIButton) {
        for button in starsButton {
            if button.tag <= sender.tag {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            if sender.tag <= 200 {
                if button.tag == 100 {
                    button.setImage(UIImage(named: "terribleActiveGrey"), for: .selected)
                }else if button.tag == 200 {
                    button.setImage(UIImage(named: "veryBadActiveGrey"), for: .selected)
                }
            }else{
                if button.tag == 100 {
                    button.setImage(UIImage(named: "terribleActive"), for: .selected)
                }else if button.tag == 200 {
                    button.setImage(UIImage(named: "veryBadActive"), for: .selected)
                }
            }
        }
        
    }
}
