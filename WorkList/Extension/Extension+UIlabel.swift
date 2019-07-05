//
//  Extension+UIlabel.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/10/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import Foundation

extension UILabel {
    func setupStrikeLine(value: Int) -> UILabel {
        let attributeString = NSMutableAttributedString(string: self.text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: value,
                                     range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
        return self
    }
}
