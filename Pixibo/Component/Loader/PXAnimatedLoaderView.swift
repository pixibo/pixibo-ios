//
//  PXAnimatedLoaderView.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 3/9/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
import Lottie

class PXAnimatedLoaderView: UIView {

    var loader: LOTAnimationView = {
        let pomeloAnimation = LOTAnimationView(name: "Pomelo_Loading")
        // Set view to full screen, aspectFill
        pomeloAnimation.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        pomeloAnimation.contentMode = .scaleAspectFill
        pomeloAnimation.frame = CGRect(x:0, y:0, width: 100, height: 100)
        pomeloAnimation.loopAnimation = true

        // Add the Animation
        pomeloAnimation.play()
        return pomeloAnimation
    }()
    
    var loaderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.loaderFont
        label.textColor = UIColor.darkBlackGrey
        label.text = "Finding the best size for you"
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        loader.center = self.center
        self.backgroundColor = UIColor.lightBrownGrey
        self.addSubview(loader)
        self.addSubview(loaderLabel)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loaderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -47),
            loader.heightAnchor.constraint(equalToConstant: 300),
            loader.widthAnchor.constraint(equalToConstant: 300)
            ])

        NSLayoutConstraint.activate([
            loaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loaderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 47)
            ])
        self.bringSubviewToFront(loaderLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        self.loader.stop()
    }
}
