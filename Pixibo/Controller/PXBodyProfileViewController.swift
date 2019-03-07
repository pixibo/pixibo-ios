//
//  PXBodyProfileViewController.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/24/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXBodyProfileViewController: UIViewController {

    @IBOutlet weak var bodyProfileTableView: UITableView!
    @IBOutlet weak var nextButton: PXButton!
    lazy var popOver: Popover = {
        let options: [PopoverOption] = [.showBlackOverlay(true),
                                        .color(UIColor.white)]
        let popover = Popover(options: options)
        return popover
    }()

    var bodyProfileModel: PRBodyProfileModel?
    var dataManager = PXDataManager.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "FIND YOUR SIZE"
        setBackgroundColor()
        self.navigationController?.navigationBar.navigationBarSetup()
        addLeftBarButton("back", self, action: #selector(didUserClickeLeftButton))
        addRightBarButton("infoPm", self, action: #selector(didUserClickeRightButton(_:)))
        
        self.registerForKeyboardNotification()
        if let json   =  PXUtility.getLocalFile(fileName: "localData", type: "Json") as? [String: AnyObject] {
            bodyProfileModel = PRBodyProfileModel(json: json)
        }
        nextButton.setUpPrimaryButton()
        nextButton.disableUI()
        loadXIB()
    }
    
    
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    func loadXIB() {
        let nib = UINib(nibName: PXBodyProfileCell.className, bundle: Bundle.main)
        bodyProfileTableView.register(nib, forCellReuseIdentifier: PXBodyProfileCell.className)
        
        let nib1 = UINib(nibName: PXBraSizeCell.className, bundle: Bundle.main)
        bodyProfileTableView.register(nib1, forCellReuseIdentifier: PXBraSizeCell.className)
        
        let headerNib = UINib(nibName: PXHeaderTitleCell.className, bundle: Bundle.main)
        bodyProfileTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PXHeaderTitleCell.className)

    }

    // MARK: - Navigation
    @objc func didUserClickeLeftButton() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func didUserClickeRightButton(_ sender: UIButton) {
        guard let privacyView = Bundle.main.loadNibNamed(PXPrivacyView.className, owner: self, options: nil)?.first as? PXPrivacyView,
                let sourceView = self.navigationItem.rightBarButtonItems?.first?.view
            else { return }
        privacyView.frame.size = CGSize(width: 214, height: 145)
        privacyView.setUpUI()
        popOver.show(privacyView, fromView: sourceView)
    }
    
    // MARK: - Navigation
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        PXLoaderManager.sharedManager.show()
        let params = [PXJSONKeysConstant.bodyProfile.height: getHeight(),
                      PXJSONKeysConstant.bodyProfile.weight: getWeight(),
                      PXJSONKeysConstant.bodyProfile.region: getRegion(),
                      PXJSONKeysConstant.bodyProfile.bust: getBand(),
                      PXJSONKeysConstant.bodyProfile.ftp: PXConstant.firPrefType.PXRegular.rawValue,
                      PXJSONKeysConstant.bodyProfile.cup: getCup()]
        dataManager.fitPrefParams = params
        PXWebServiceManager.sharedManager.getSizeRecommendation(params: params) { (response, error) in
            PXLoaderManager.sharedManager.hide()
            DispatchQueue.main.async {
                if let _ = error {
                    self.addAlert()
                } else {
                    if let resp = response as? Dictionary<String, Any> {
                        let result = PXResultModel.init(json: resp)
                        self.dataManager.resultModel = result
                        self.moveTo()
                    }
                }
            }
            
        }
        
    }
    
    func addAlert() {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.okButtonHandler = {
            
        }
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func getHeight() -> String {
        let indexpathForEmail = IndexPath.init(row: 0, section: 0)
        let emailCell = bodyProfileTableView.cellForRow(at: indexpathForEmail) as! PXBodyProfileCell
        return String(format: "%i",(Int((emailCell.rangeSlider?.value ?? 0))))
    }
    func getWeight() -> String {
        let indexpathForEmail = IndexPath.init(row: 1, section: 0)
        let emailCell = bodyProfileTableView.cellForRow(at: indexpathForEmail) as! PXBodyProfileCell
        let value = emailCell.unitSegment.selectedSegmentIndex == 0 ? emailCell.rangeSlider?.value : emailCell.rangeSlider?.value.toKg
        return String(format: "%i",(Int(value ?? 0)))
    }
    func getRegion() -> String {
        let indexpathForEmail = IndexPath.init(row: 2, section: 0)
        let emailCell = bodyProfileTableView.cellForRow(at: indexpathForEmail) as! PXBraSizeCell
        return emailCell.zoneTextField.text!
    }
    func getBand() -> String {
        let indexpathForEmail = IndexPath.init(row: 2, section: 0)
        let emailCell = bodyProfileTableView.cellForRow(at: indexpathForEmail) as! PXBraSizeCell
        return emailCell.bandTextField.text!
    }
    func getCup() -> String {
        let indexpathForEmail = IndexPath.init(row: 2, section: 0)
        let emailCell = bodyProfileTableView.cellForRow(at: indexpathForEmail) as! PXBraSizeCell
        return emailCell.cupSizeTextField.text!
    }
    
    
    func moveTo() {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let fitVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXFitPreferenceViewController)
        self.navigationController?.pushViewController(fitVC, animated: true)
    }
    deinit {
        unregisterNotifications()
    }
    
}

extension PXBodyProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return 124
        }
        return 174
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PXHeaderTitleCell.className) as? PXHeaderTitleCell
        headerView?.updateUI(color: .clear, title: "Enter your height, weight, and bra size.\n\nWe've got you.")
        headerView?.titleLabel.font = UIFont.AKRegularParagraphStyle
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXBodyProfileCell.className) as? PXBodyProfileCell
                else { return UITableViewCell()}
            cell.data = bodyProfileModel?.height
            cell.cellType = .PXBodyProfileHeight
            cell.updateUI()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXBodyProfileCell.className) as? PXBodyProfileCell
                else { return UITableViewCell()}
            cell.data = bodyProfileModel?.weight
            cell.cellType = .PXBodyProfileWeight
            cell.updateUI()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXBraSizeCell.className) as? PXBraSizeCell
                else { return UITableViewCell()}
            cell.data = bodyProfileModel?.braSize
            cell.delegate = self
            cell.updateUI()
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PXBodyProfileCell.className) as? PXBodyProfileCell
                else { return UITableViewCell()}
            return cell
        }
        
    }
    
}


extension PXBodyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
       
    }

}

extension PXBodyProfileViewController: PXBraSizeDelegate {
    func loadScreen(cell: PXBraSizeCell, tag: Int, selectedVal: String?) {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let examplePicker = storyBoard.instantiateViewController(withIdentifier: PXCustomPickerViewController.className) as! PXCustomPickerViewController
        examplePicker.modalPresentationStyle = .overCurrentContext
        examplePicker.modalTransitionStyle = .crossDissolve
        examplePicker.dataSource = cell
        examplePicker.delegate = cell
        examplePicker.tag = tag
        examplePicker.selectedVal = selectedVal ?? ""
        self.present(examplePicker, animated: true, completion: nil)
    }
    
    func isValid(status: Bool) {
        status ? nextButton.enableUI() : nextButton.disableUI()
    }
}

extension PXBodyProfileViewController {
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillDown(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyBoardWillShow(_ notification: Notification) {
        guard let table = bodyProfileTableView, let activeField = bodyProfileTableView.findFirstResponder() else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            table.contentInset          = contentInsets;
            table.scrollIndicatorInsets = contentInsets;
            var aRect : CGRect = table.frame
            aRect.size.height -= keyboardSize.height
            let newRect =  activeField.convert(CGRect(origin: .zero, size: activeField.frame.size), to: table)
            if !aRect.contains(newRect.origin) {
                table.scrollRectToVisible(newRect, animated: true)
            }
        }
    }
    
    @objc func keyBoardWillDown(_ notification: Notification) {
        let contentInset : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bodyProfileTableView.contentInset = contentInset
        bodyProfileTableView.scrollIndicatorInsets = contentInset
    }
}
