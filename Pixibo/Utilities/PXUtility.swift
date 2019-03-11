//
//  PXUtility.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
import Lottie

class PXUtility {

    class func getLocalFile(fileName : String, type : String) -> Any?{
        if let path = Bundle.main.path(forResource: fileName, ofType: type){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return json
            } catch {
            }
        }
        return nil
    }

    class func convertFootAndInchesFromCm(_ cms: Double) -> String {
        
        let feet = cms * 0.0328084
        let feetShow = Int(floor(feet))
        let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRest * 12))
        return "\(feetShow).\(inches)"
    }

    class func showLbsFromKg(_ kg: Double) -> String {
        let feet = kg * 2.20462
        let feetShow = Int((feet))
        return "\(feetShow) LB"
    }
    
    class func showFootAndInchesFromCm(_ cms: Double) -> String {
        
        let feet = cms * 0.0328084
        let feetShow = Int(floor(feet))
        let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRest * 12))
        return "\(feetShow)' \(inches)\""
    }
    
    class func getUniqueID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    class func getConvertedSizeString(size: String) -> String {
        if size == "INT XS" {
            return "Size XS"
        } else if size == "INT S" {
            return "Size S"
        } else if size == "INT M" {
            return "Size M"
        } else if size == "INT L" {
            return "Size L"
        } else if size == "INT XL" {
            return "Size XL"
        } else if size == "INT XXL" {
            return "Size XXL"
        } else if size == "INT XXXL" {
            return "Size XXXL"
        } else {
            return ""
        }
    }
    
    class func getTopMostController () -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow else {
            return nil
        }
        if var topController = window.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    class func loadPixiboController() {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "PXBodyProfileViewController") as! UINavigationController
        VC1.navigationBar.navigationBarSetup()

        if let _ = PXDataManager.sharedManager.resultModel {
            let fitVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXFitPreferenceViewController)
            let resultVC = storyBoard.instantiateViewController(withIdentifier: PXConstant.ViewControllerID.PXResultViewController) as! PXResultViewController
            resultVC.result = true
            VC1.viewControllers.append(fitVC)
            VC1.viewControllers.append(resultVC)
        }
        
        getTopMostController()?.present(VC1, animated:false, completion: nil)
        
    }

    class func addAlert() {
        let storyBoard = UIStoryboard(name: PXConstant.StoryBoard.name, bundle: nil)
        let customAlert = storyBoard.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.okButtonHandler = {
            
        }
        getTopMostController()?.present(customAlert, animated: true, completion: nil)
    }

    static func addCustomLoader(with width: CGFloat) -> LOTAnimationView{
        let animation = LOTAnimationView(name: "Pomelo_Loading")
        animation.frame = CGRect(x:0, y:0, width: width, height: width)
        animation.contentMode = .scaleAspectFill
        animation.loopAnimation = true
        return animation
    }

}
