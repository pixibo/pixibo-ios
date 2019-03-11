//
//  PXFitPreferenceController.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXFitPreferenceViewController: UIViewController {

    @IBOutlet weak var prefTableView: UITableView!
    @IBOutlet weak var tellMySizeButton: PXButton!
    var isFitPrefChanged = false
    
    lazy var popOver: Popover = {
        let options: [PopoverOption] = [.showBlackOverlay(true),
                                        .color(UIColor.white)]
        let popover = Popover(options: options)
        return popover
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addLeftBarButton("back", self, action: #selector(didUserClickeLeftButton))
        addRightBarButton("infoPm", self, action: #selector(didUserClickeRightButton))
        tellMySizeButton.setUpPrimaryButton()
        loadXIB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "FIND YOUR SIZE"
        if let item = getRecommendedItem(){
            PXDataManager.sharedManager.setEntryPageTitleOnSelection(text: PXUtility.getConvertedSizeString(size: item.size ?? ""))
        }else {
            PXDataManager.sharedManager.setEntryPageTitle(title: "CHECK YOUR FIT")
        }
    }
    
    func getRecommendedItem() -> fys? {
        if let element = PXDataManager.sharedManager.resultModel,
            let local = element.resultArr.first(where: {$0.recommended == 1}) {
            return local
        }
        return nil
    }
    
    func loadXIB() {
        
        let nib1 = UINib(nibName: PXFitPrefCell.className, bundle: Bundle.main)
        prefTableView.register(nib1, forCellReuseIdentifier: PXFitPrefCell.className)
        
        let headerNib = UINib(nibName: PXHeaderTitleCell.className, bundle: Bundle.main)
        prefTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PXHeaderTitleCell.className)
        
    }

    
    // MARK: - Navigation
    @objc func didUserClickeLeftButton() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func didUserClickeRightButton() {
        guard let privacyView = Bundle.main.loadNibNamed(PXPrivacyView.className, owner: self, options: nil)?.first as? PXPrivacyView,
            let sourceView = self.navigationItem.rightBarButtonItems?.first?.view
            else { return }
        privacyView.frame.size = CGSize(width: 214, height: 145)
        privacyView.setUpUI()
        popOver.show(privacyView, fromView: sourceView)
        
    }
    
    // MARK: - Navigation
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tellMySizeButtonClicked(_ sender: Any) {
        PXLoaderManager.sharedManager.showAnimated()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if PXDataManager.sharedManager.selectedFirPrefType == .PXRegular && self.isFitPrefChanged == false{
                let result = PXDataManager.sharedManager.resultModel
                let res = (result?.resultArr.count ?? 0) > 0 ? true : false
                self.moveToResultController(result: res)
                
            } else {
                self.isFitPrefChanged = true
                self.fetchUpdatedSizePref()
            }
        })
    }

    func moveToResultController(result: Bool) {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let resultVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXResultViewController) as? PXResultViewController
        resultVC?.result = result
        self.navigationController?.pushViewController(resultVC!, animated: true)
        PXLoaderManager.sharedManager.hideAnimated()

    }
    
    func fetchUpdatedSizePref() {
       
        guard var params = PXDataManager.sharedManager.fitPrefParams else {
            return
        }
        params[PXJSONKeysConstant.bodyProfile.ftp] = PXDataManager.sharedManager.selectedFirPrefType.rawValue
        
        PXWebServiceManager.sharedManager.getSizeRecommendation(params: params) { (response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    self.addAlert()
                } else {
                    if let resp = response as? Dictionary<String, Any> {
                        let result = PXResultModel.init(json: resp)
                        PXDataManager.sharedManager.resultModel = result
                        let res = result.resultArr.count > 0 ? true : false
                        self.moveToResultController(result: res)
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
            self.fetchUpdatedSizePref()
        }
        self.present(customAlert, animated: true, completion: nil)
    }

}

extension PXFitPreferenceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Here if we will get recommended item then we will show the header in yellow view
        /// 
        if let _ = getRecommendedItem(){
            return 66
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let item = getRecommendedItem(){
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PXHeaderTitleCell.className) as? PXHeaderTitleCell
            headerView?.titleLabel.font = UIFont.subheads
            headerView?.updateUI(color: .brightYellow, title: "We recommend this in \(PXUtility.getConvertedSizeString(size: item.size ?? "")).\n For a better fit, tell us your personal fit preference.", lineHeight: 4)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PXFitPrefCell.className) as? PXFitPrefCell
            else { return UITableViewCell()}
        cell.cellType = .PXBodyFitPref
        cell.setUI()
        cell.delegate = self
        return cell
    }
    
}

extension PXFitPreferenceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}

extension PXFitPreferenceViewController: PXFitPrefCellDelegate {
    func selectedFitPref(type: PXConstant.firPrefType) {
        PXDataManager.sharedManager.selectedFirPrefType = type
    }
}
