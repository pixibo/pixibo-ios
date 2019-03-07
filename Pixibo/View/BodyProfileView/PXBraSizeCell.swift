//
//  PXBraSizeCell.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

protocol PXBraSizeDelegate : class {
    func isValid(status: Bool)
    func loadScreen(cell: PXBraSizeCell, tag: Int, selectedVal: String?)
}

class PXBraSizeCell: UITableViewCell {

    @IBOutlet weak var zoneTextField: PXTextField!
    @IBOutlet weak var bandTextField: PXTextField!
    @IBOutlet weak var cupSizeTextField: PXTextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var regionErrorView: UIView!
    @IBOutlet weak var cupErrorView: UIView!
    @IBOutlet weak var bandErrorView: UIView!
    
    
    var myPickerData1:[String] = []
    var myPickerData2:[String] = []
    var myPickerData3:[String] = []
    var data: PRBodyBraSizeModel?
    
    weak var delegate: PXBraSizeDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        errorLabel.isHidden = true
        zoneTextField.inputView = UIView()
        zoneTextField.delegate = self
        zoneTextField.tag = 1000
        
        bandTextField.inputView = UIView()
        bandTextField.delegate = self
        bandTextField.tag = 2000
        
        
        cupSizeTextField.inputView = UIView()
        cupSizeTextField.delegate = self
        cupSizeTextField.isUserInteractionEnabled = false
        cupSizeTextField.tag = 3000
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI()  {
        guard let ddd = data else { return }
        myPickerData1 = ddd.type
        if let key = zoneTextField.text, !key.isEmpty {
            myPickerData2 = data?.band[key] as! [String]
        }
        if let key = zoneTextField.text, !key.isEmpty, let band = ddd.cup[key] as? [String] {
            myPickerData3 = band
        }
        if let key = zoneTextField.text, !key.isEmpty, let cup = ddd.cup[key] as? [String] {
            myPickerData3 = cup
        }
        zoneTextField.text = myPickerData1[0] // default value
        updateBandandCup()
    }
    
    func updateBandandCup() {
        guard let ddd = data else { return }
        if let key = zoneTextField.text, !key.isEmpty {
            myPickerData2 = data?.band[key] as! [String]
        }
        if let key = zoneTextField.text, !key.isEmpty, let band = ddd.cup[key] as? [String] {
            myPickerData3 = band
        }
        if let key = zoneTextField.text, !key.isEmpty, let cup = ddd.cup[key] as? [String] {
            myPickerData3 = cup
        }
        bandTextField.isUserInteractionEnabled = true
        cupSizeTextField.isUserInteractionEnabled = true
    }
    
    func validateInput() {
        if (zoneTextField.text?.isEmpty)! || (bandTextField.text?.isEmpty)! || (cupSizeTextField.text?.isEmpty)! {
            delegate?.isValid(status: false)
            updateOnError(error: true)
        } else {
            delegate?.isValid(status: true)
            updateOnError(error: false)
        }
        
    }
    
    func updateOnError(error: Bool) {
        if error {
            errorLabel.isHidden = false
            errorLabel.textColor = .coralPink
            if zoneTextField.text?.isEmpty ?? false {
                regionErrorView.backgroundColor = .coralPink
            }else {
                regionErrorView.backgroundColor = .darkBrownGrey
            }
            if bandTextField.text?.isEmpty ?? false {
                bandErrorView.backgroundColor = .coralPink
            }else {
                bandErrorView.backgroundColor = .darkBrownGrey
            }
            if cupSizeTextField.text?.isEmpty ?? false {
                cupErrorView.backgroundColor = .coralPink
            }else {
                cupErrorView.backgroundColor = .darkBrownGrey
            }

        } else{
            errorLabel.isHidden = true
            regionErrorView.backgroundColor = .darkBrownGrey
            bandErrorView.backgroundColor = .darkBrownGrey
            cupErrorView.backgroundColor = .darkBrownGrey
        }
    }
}

extension PXBraSizeCell: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1000:
            delegate?.loadScreen(cell: self, tag: 1000, selectedVal: textField.text)
        case 2000:
            delegate?.loadScreen(cell: self, tag: 2000, selectedVal: textField.text)
        default:
            delegate?.loadScreen(cell: self, tag: 3000, selectedVal: textField.text)
        }
    }
}

extension PXBraSizeCell:PickerViewDataSource  {
    func pickerViewNumberOfRows(_ pickerView: PXCustomPickerViewController) -> Int {
        switch pickerView.tag {
        case 1000:
            return myPickerData1.count
        case 2000:
            return myPickerData2.count
        default:
            return myPickerData3.count
        }

    }
    
    func pickerView(_ pickerView: PXCustomPickerViewController, titleForRow row: Int) -> String {
        switch pickerView.tag {
        case 1000:
            return myPickerData1[row]
        case 2000:
            return myPickerData2[row]
        default:
            return myPickerData3[row]
        }

    }
    
    func pickerViewTitle(_ pickerView: PXCustomPickerViewController) -> String {
        switch pickerView.tag {
        case 1000:
            return "REGION"
        case 2000:
            return "BAND"
        default:
            return "CUP"
        }
    }
}

extension PXBraSizeCell: PickerViewDelegate {
    func pickerView(_ pickerView: PXCustomPickerViewController, didSelectRow row: Int) {
        switch pickerView.tag {
        case 1000:
            zoneTextField.text = myPickerData1[row]
            self.zoneTextField.resignFirstResponder()
            updateBandandCup()
            bandTextField.text = ""
            cupSizeTextField.text = ""
        case 2000:
            bandTextField.text = myPickerData2[row]
            self.bandTextField.resignFirstResponder()
        case 3000:
            cupSizeTextField.text = myPickerData3[row]
            self.cupSizeTextField.resignFirstResponder()
        default:
            self.zoneTextField.resignFirstResponder()
        }
        validateInput()
    }
    
    func pickerView(_ pickerView: PXCustomPickerViewController, didTapOutSide row: Int) {
        switch pickerView.tag {
        case 1000:
            self.zoneTextField.resignFirstResponder()
        case 2000:
            self.bandTextField.resignFirstResponder()
        case 3000:
            self.cupSizeTextField.resignFirstResponder()
        default:
            self.zoneTextField.resignFirstResponder()
        }
        validateInput()
    }

}
