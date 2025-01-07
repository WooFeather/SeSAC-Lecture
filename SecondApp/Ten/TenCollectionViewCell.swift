//
//  TenCollectionViewCell.swift
//  SecondApp
//
//  Created by 조우현 on 1/7/25.
//

import UIKit

class TenCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.backgroundColor = .brown
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }
}
