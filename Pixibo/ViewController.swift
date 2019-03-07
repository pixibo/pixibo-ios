//
//  ViewController.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/23/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var entryButton: PXTagView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        entryButton.setAttributedTitle(PXDataManager.sharedManager.pdpPageString, for: .normal)
    }
    
    @IBAction func getYourSizeButtonClicked(_ sender: Any) {
        loadPixiboController()
    }
    
    
    func loadPixiboController() {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "PXBodyProfileViewController") as! UINavigationController
        if let _ = PXDataManager.sharedManager.resultModel {
            let fitVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXFitPreferenceViewController)
            let resultVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXResultViewController) as! PXResultViewController
            resultVC.result = true
            VC1.viewControllers.append(fitVC)
            VC1.viewControllers.append(resultVC)
        }
       
        self.present(VC1, animated:false, completion: nil)

    }
    
    /*
     func moveTo() {
     let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
     let fitVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXFitPreferenceViewController)
     self.navigationController?.pushViewController(fitVC, animated: true)
     }
     
     func moveToResultController(result: Bool) {
     let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
     let resultVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXResultViewController) as? PXResultViewController
     resultVC?.result = result
     self.navigationController?.pushViewController(resultVC!, animated: true)
     }
     
     */
}

