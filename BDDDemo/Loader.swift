//
//  Loader.swift
//  BDDDemo
//
//  Created by Abhishek C Sreejith on 27/02/24.
//
import UIKit
class Loader: UIView {
    // Animation View
    var animationView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set overlay bg color
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        // Configuring Animation.
        animationView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        animationView.startAnimating()
        addSubview(animationView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }
