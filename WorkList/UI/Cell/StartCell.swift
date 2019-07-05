//
//  StartCell.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/8/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class StartCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var bottomImage: UIImageView!
    
    func setcontentFor(cell data: DataStartCell) {
        topImage.image = UIImage(named: data.topImage)
        firstLabel.text = data.firstLabelText
        secondLabel.text = data.secondlabelText
        bottomImage.image = UIImage(named: data.bottomImage)
    }
}
