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
        resetUI()
    }
    
    @IBAction func rangeSliderValueChanged(_ sender: Any) {
        if ((data as? PRBodyHeightModel) != nil) && unitSegment.selectedSegmentIndex == 1 {
            setSelectedLabel(type: 1)
        } else {
            setSelectedLabel(type: 0)
        }
    }
    
    @IBAction func incrementButtonClicked(_ sender: Any) {
        rangeSlider.value = rangeSlider.value + 1.0
        if ((data as? PRBodyHeightModel) != nil) && unitSegment.selectedSegmentIndex == 1 {
            setSelectedLabel(type: 1)
        } else {
            setSelectedLabel(type: 0)
        }
        
    }
    
    @IBAction func decrementButtonClicked(_ sender: Any) {
        rangeSlider.value = rangeSlider.value - 1.0
        if ((data as? PRBodyHeightModel) != nil) && unitSegment.selectedSegmentIndex == 1 {
            setSelectedLabel(type: 1)
        } else {
            setSelectedLabel(type: 0)
        }
    }
    
    func updateUI() {
        if let height = data as? PRBodyHeightModel {
            titleLabel.text = height.title
            if unitSegment.selectedSegmentIndex == 0 {
                rangeSlider.minimumValue = Float(height.cmRange.first!)
                rangeSlider.maximumValue = Float(height.cmRange.last!)
                rangeSlider.value = 160 // default value
            }
            setSelectedLabel(type: 0)
            unitSegment.commaSeperatedButtonTitles = "CM, FT"
            
        }else if let weight = data as? PRBodyWeightModel {
            titleLabel.text = weight.title
            if unitSegment.selectedSegmentIndex == 0 {
                rangeSlider.minimumValue = Float(weight.kgRange.first!)
                rangeSlider.maximumValue = Float(weight.kgRange.last!)
                rangeSlider.value = 50 // default value
            }
            setSelectedLabel(type: 0)
            unitSegment.commaSeperatedButtonTitles = "KG, LB"
        }
        
        
    }
    
    func resetUI() {
        if let _ = data as? PRBodyHeightModel, cellType == .PXBodyProfileHeight {
            rangeSlider.value = rangeSlider.value
            if unitSegment.selectedSegmentIndex == 0 {
                setSelectedLabel(type: 0)
            } else {
                setSelectedLabel(type: 1)
            }
        } else if let weight = data as? PRBodyWeightModel, cellType == .PXBodyProfileWeight {
            if unitSegment.selectedSegmentIndex == 0 {
                rangeSlider.minimumValue = Float(weight.kgRange.first!)
                rangeSlider.maximumValue = Float(weight.kgRange.last!)
                rangeSlider.value = rangeSlider.value.toKg // * 0.453592
            } else {
                rangeSlider.minimumValue = Float(weight.lbsRange.first!)
                rangeSlider.maximumValue = Float(weight.lbsRange.last!)
                rangeSlider.value = rangeSlider.value.toLb // * 2.20462
            }
            setSelectedLabel(type: 0)

        }
    }
    
    func getUnitString() -> String {
        var unitString = ""
        if cellType == .PXBodyProfileHeight && unitSegment.selectedSegmentIndex == 0 {
            unitString = " CM"
        } else if cellType == .PXBodyProfileHeight && unitSegment.selectedSegmentIndex == 1 {
            unitString = " FT"
        } else if cellType == .PXBodyProfileWeight && unitSegment.selectedSegmentIndex == 0 {
            unitString = " KG"
        } else if cellType == .PXBodyProfileWeight && unitSegment.selectedSegmentIndex == 1 {
            unitString = " LB"
        }
        return unitString
    }
    
    func setSelectedLabel(type: Int) {
        if type == 1 {
            selectedValueLabel.text = PXUtility.showFootAndInchesFromCm(Double(rangeSlider?.value ?? 0))
        }else {
            selectedValueLabel.text = String(format: "%i",Int(rangeSlider.value)) + getUnitString()
        }
    }
}
