//
//  SampleCollectionViewCell.swift
//  SeSACThirdWeek
//
//  Created by 조우현 on 1/9/25.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SampleCollectionViewCell"
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // layoutSubViews
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
//    }
}
