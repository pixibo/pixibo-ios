//
//  CustomAlertView.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 3/6/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class CustomAlertView: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var okButton: UIButton!
    var okButtonHandler: (() -> Swift.Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 13
        okButton.layer.cornerRadius = 8
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        okButtonHandler!()
        self.dismiss(animated: true, completion: nil)
    }
    
}
