//
//  PXFitConfidenceCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/29/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXFitConfidenceCell: UITableViewCell {

    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starRatingValueChanged(_ sender: SwiftyStarRatingView) {
        starRatingViewValueChange()
    }
    
    func starRatingViewValueChange() {

    }
}
