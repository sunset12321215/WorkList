//
//  HeaderTableView.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/15/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class HeaderTableView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderTableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
