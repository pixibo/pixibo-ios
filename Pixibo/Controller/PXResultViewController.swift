//
//  PXResultViewController.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXResultViewController: UIViewController {
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var addToBagButton: PXButton!
    @IBOutlet weak var backButton: PXButton!
    var result = false
    var selectedFys: fys?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addLeftBarButton("back", self, action: #selector(didUserClickeLeftButton))
        self.title = "YOUR SIZE"
        selectedFys = PXDataManager.sharedManager.resultModel?.resultArr.first
        loadXIB()
        addToBagButton.setUpPrimaryButton()
        backButton.setUpSecondaryButton()
        backButton.addBorder()
        resultTableView.estimatedRowHeight = 90
        resultTableView.rowHeight = UITableView.automaticDimension
        if result {
            addToBagButton.setTitle("ADD TO BAG", for: .normal)
            backButton.setTitle("START OVER", for: .normal)
        } else {
            addToBagButton.setTitle("CONTINUE SHOPPING", for: .normal)
            backButton.setTitle("START OVER", for: .normal)
        }

    }
    
    func loadXIB() {
        
        let size = UINib(nibName: PXResultSizeCell.className, bundle: Bundle.main)
        resultTableView.register(size, forCellReuseIdentifier: PXResultSizeCell.className)
        
        let nib1 = UINib(nibName: PXHowItFitsCell.className, bundle: Bundle.main)
        resultTableView.register(nib1, forCellReuseIdentifier: PXHowItFitsCell.className)
        
        let nib2 = UINib(nibName: PXFitConfidenceNewCell.className, bundle: Bundle.main)
        resultTableView.register(nib2, forCellReuseIdentifier: PXFitConfidenceNewCell.className)
        
        let headerNib = UINib(nibName: PXHeaderTitleCell.className, bundle: Bundle.main)
        resultTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PXHeaderTitleCell.className)
        
    }

    
    // MARK: - Navigation
    @objc func didUserClickeLeftButton() {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func backButtonClicked(_ sender: Any) {
        if result {
            self.navigationController?.popToRootViewController(animated: true)
        }else {
            self.navigationController?.popToRootViewController(animated: false)
        }
        PXDataManager.sharedManager.reset()
    }
    
    @IBAction func addToBagButtonClicked(_ sender: Any) {
        //TODO : Third party implementation
        
    }

}

extension PXResultViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return result ? 190 : 175
//        case 1:
//            return 150
//        case 2:
//            return 175
//        default:
//            return 0
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !result {
            return 42
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !result {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PXHeaderTitleCell.className) as? PXHeaderTitleCell
            headerView?.updateUI(color: UIColor.black, title: "Sorry, this item is out of stock in this size.", textColor: .white)
            headerView?.titleLabel.font = UIFont.subheads
            return headerView
        }
        return nil
    }
    //2ca2d1b4d27289f40a9b3960f6d05432181af91f
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXResultSizeCell.className) as? PXResultSizeCell
                else { return UITableViewCell()}
            cell.delegate = self
            cell.setTitlTopMargin(isAvailable: result)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXFitConfidenceNewCell.className) as? PXFitConfidenceNewCell
                else { return UITableViewCell()}
                if let data = selectedFys{
                    cell.setUI(selected: data.confidence ?? 0)
                }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXHowItFitsCell.className) as? PXHowItFitsCell
                else { return UITableViewCell()}
            if let data = selectedFys{
                cell.updateUI(data: data)
            }
            return cell
        }
    }
    
}

extension PXResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension PXResultViewController: PXResultSizeCellDelegate {
    func didClickedOnRegularButton() {
        self.navigationController?.popViewController(animated: true)
    }
    func didUserChangeSize(index: Int) {
        selectedFys = PXDataManager.sharedManager.resultModel?.resultArr[index]
        self.resultTableView.reloadData()
    }
}

//extension PXResultViewController: PXHowItFitsCellDelegate {
//    func didClickedOnExpandButton() {
//        let indexPath = IndexPath(row: 2, section: 0)
//
//        let emailCell = resultTableView.cellForRow(at: indexPath) as! PXHowItFitsCell
//        emailCell.audioPlaybackView.isHidden = !emailCell.audioPlaybackView.isHidden
//        if emailCell.audioPlaybackView.isHidden {
//            expandedCellPaths = true
//        } else {
//            expandedCellPaths = false
//        }
//        resultTableView.beginUpdates()
//        resultTableView.reloadRows(at: [indexPath], with: .fade)
//        resultTableView.endUpdates()
//    }
//
//}
