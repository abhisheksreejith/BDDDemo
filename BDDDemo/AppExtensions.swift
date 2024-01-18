//
//  AppExtensions.swift
//  BDDDemo
//
//  Created by Abhishek C Sreejith on 28/02/24.
//

import UIKit
extension UIView {
    // Show/Hide loader.
    func showLoader() {
            let loader = Loader(frame: frame)
            self.addSubview(loader)
        
    }
    func hideLoader() {
        if let loader = subviews.first(where: { $0 is Loader }) {
            loader.removeFromSuperview()
        }
    }
}
