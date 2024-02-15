//
//  UILabel + Extension.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.numberOfLines = 0
        self.text = text
        self.font = .robotoMedium12()
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    convenience init(text: String? = "", font: UIFont?, textColor: UIColor, numberOfLines: Int = 0) {
        self.init()
        self.numberOfLines = numberOfLines
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
