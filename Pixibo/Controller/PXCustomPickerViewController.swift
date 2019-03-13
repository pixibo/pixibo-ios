//
//  PXCustomPickerViewController.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 3/3/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

@objc protocol PickerViewDataSource: class {
    func pickerViewNumberOfRows(_ pickerView: PXCustomPickerViewController) -> Int
    func pickerView(_ pickerView: PXCustomPickerViewController, titleForRow row: Int) -> String
    func pickerViewTitle(_ pickerView: PXCustomPickerViewController) -> String
}

@objc protocol PickerViewDelegate: class {
    @objc optional func pickerView(_ pickerView: PXCustomPickerViewController, didSelectRow row: Int)
    @objc optional func pickerView(_ pickerView: PXCustomPickerViewController, didTapOutSide row: Int)
}

class PXCustomPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    var tag = 0
    var selectedVal = ""
    
    weak var dataSource: PickerViewDataSource?
    weak var delegate: PickerViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = dataSource?.pickerViewTitle(self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        addBlur()
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            //This code will run in the main thread:
            var frame = self.tableView.frame
            if self.tableView.contentSize.height > 0.7*self.view.bounds.height {
                frame.size.height = self.view.bounds.height * 0.7
            }else {
                frame.size.height = self.tableView.contentSize.height
            }
            self.tableView.frame = frame
            self.tableViewHeight.constant = frame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    func addBlur() {
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            view.bringSubviewToFront(tableView)
        } else {
            view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        }
        let tapOnScreen = UITapGestureRecognizer.init(target: self, action: #selector(didUserClickedOnbackground))
        tapOnScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOnScreen)
    }
    //MARK: Tap action
    @objc func didUserClickedOnbackground() {
        delegate?.pickerView?(self, didTapOutSide: 0)
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }

    }
}
extension PXCustomPickerViewController: UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.pickerViewNumberOfRows(self) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PXCustomPickerCell.className) as? PXCustomPickerCell
            else { return UITableViewCell()}
        let data = dataSource?.pickerView(self, titleForRow: indexPath.row)
        cell.titleLabel.text = data
        if !selectedVal.isEmpty && selectedVal == data {
            cell.pickerImageView.isHighlighted = true
        }else {
            cell.pickerImageView.isHighlighted = false
        }
        return cell
    }
    
}

extension PXCustomPickerViewController: UITableViewDelegate {
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pickerView?(self, didSelectRow: indexPath.row)
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}

class PXCustomPickerCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
