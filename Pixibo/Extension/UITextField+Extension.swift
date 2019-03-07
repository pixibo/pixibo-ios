//
//  UITextField+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

extension UITextField {

    func addRightImageView(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height))
        imageView.backgroundColor = UIColor.primaryColor()
        imageView.image = image
        imageView.isUserInteractionEnabled = false
        imageView.layer.cornerRadius = self.layer.cornerRadius
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        imageView.layer.borderColor = UIColor.secondaryColor().cgColor
        imageView.layer.borderWidth = 4
        return imageView
    }
}
