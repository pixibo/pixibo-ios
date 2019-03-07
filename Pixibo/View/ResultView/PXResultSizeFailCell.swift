//
//  PXResultSizeFailCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/3/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
protocol PXResultSizeFailCellDelegate: class {
    func didClickedOnRegularButton()
}

class PXResultSizeFailCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var regularButton: UIButton!
    weak var delegate:PXResultSizeFailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func regularButtonClicked(_ sender: Any) {
        if let del = delegate {
            del.didClickedOnRegularButton()
        }
    }
    
    func setUI() {
        let mutableAttributedString = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2            // Paragraph Spacing
        paragraphStyle.lineSpacing = 1.4
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]

        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
        
        
        let boldAttributedString = NSAttributedString(string: "OUR SIZES MAY NOT BE A PERFECT FIT", attributes: boldAttribute)

        let regularAttributedString = NSAttributedString(string: " IS CLOSEST TO YOUR SIZE.", attributes: regularAttribute)
        mutableAttributedString.append(boldAttributedString)
        mutableAttributedString.append(regularAttributedString)
        descriptionLabel.attributedText = mutableAttributedString
        descriptionLabel.textAlignment = .center
    }
}
