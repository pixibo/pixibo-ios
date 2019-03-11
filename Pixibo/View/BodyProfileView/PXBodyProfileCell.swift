//
//  PXBodyProfileCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXBodyProfileCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unitSegment: PXCustomSegment!
    @IBOutlet weak var rangeSlider: PXSliderView!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var selectedValueLabel: UILabel!
  
    var cellType: PXConstant.cellType = .Unknown
    
    var data: Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        unitSegment.addTarget(self, action: #selector(unitSegmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func unitSegmentValueChanged(_ sender: PXCustomSegment) {
        rangeSlider.value = rangeSlider.value
        setSelectedLabel()
    }
    
    @IBAction func rangeSliderValueChanged(_ sender: Any) {
        setSelectedLabel()
    }
    
    @IBAction func incrementButtonClicked(_ sender: Any) {
        rangeSlider.value = rangeSlider.value + 1.0
        setSelectedLabel()
    }
    
    @IBAction func decrementButtonClicked(_ sender: Any) {
        rangeSlider.value = rangeSlider.value - 1.0
        setSelectedLabel()
    }
    
    func updateUI() {
        if let height = data as? PRBodyHeightModel {
            titleLabel.text = height.title
            if unitSegment.selectedSegmentIndex == 0 {
                rangeSlider.minimumValue = Float(height.cmRange.first!)
                rangeSlider.maximumValue = Float(height.cmRange.last!)
                rangeSlider.value = 160 // default value
            }
            setSelectedLabel()
            unitSegment.commaSeperatedButtonTitles = "CM, FT"
            
        }else if let weight = data as? PRBodyWeightModel {
            titleLabel.text = weight.title
            if unitSegment.selectedSegmentIndex == 0 {
                rangeSlider.minimumValue = Float(weight.lbsRange.first!)
                rangeSlider.maximumValue = Float(weight.lbsRange.last!)
                rangeSlider.value = 110 // default value
            }
            setSelectedLabel()
            unitSegment.commaSeperatedButtonTitles = "KG, LB"
        }
    }
    
    func setSelectedLabel() {
        var unitString = ""
        if cellType == .PXBodyProfileHeight && unitSegment.selectedSegmentIndex == 0 {
            unitString = " CM"
            selectedValueLabel.text = String(format: "%i",Int(rangeSlider.value)) + unitString

        } else if cellType == .PXBodyProfileHeight && unitSegment.selectedSegmentIndex == 1 {
            unitString = " FT"
            selectedValueLabel.text = PXUtility.showFootAndInchesFromCm(Double(rangeSlider?.value ?? 0))
            
        } else if cellType == .PXBodyProfileWeight && unitSegment.selectedSegmentIndex == 0 {
            unitString = " KG"
            rangeSlider.value = rangeSlider.value + 1
            selectedValueLabel.text = String(format: "%i",Int(rangeSlider.value.toKg)) + unitString

        } else if cellType == .PXBodyProfileWeight && unitSegment.selectedSegmentIndex == 1 {
            unitString = " LB"
            selectedValueLabel.text = String(format: "%i",Int(rangeSlider.value)) + unitString
        }
    }
}
