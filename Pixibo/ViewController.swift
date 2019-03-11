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
        Pixibo.presentFyf(withSKUId: "p23209", withAltId: "user_id")
        
    }
}

