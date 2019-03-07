//
//  PXLoaderView.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/9/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXLoaderView: UIView {

    var loader: UIActivityIndicatorView = {
        let l = UIActivityIndicatorView(frame: .zero)
        l.style =  .whiteLarge
        l.color = UIColor.white
        l.hidesWhenStopped = true
        l.startAnimating()
        return l
    }()
    
    var loaderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "Loading..."
        label.textAlignment = .center
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        self.addSubview(loader)
        self.addSubview(loaderLabel)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            loaderLabel.centerXAnchor.constraint(equalTo: loader.centerXAnchor),
            loaderLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
