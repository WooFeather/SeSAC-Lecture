//
//  BookCollectionViewCell.swift
//  FourthWeek
//
//  Created by 조우현 on 1/13/25.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    let bookCoverImageView = UIImageView()
    
    // viewDidLoad,awakeFromNib
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 셀에는 contentView가 존재!! 여기에다가 뷰를 추가해주야 액션이 동작함
        contentView.addSubview(bookCoverImageView)
        
        bookCoverImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        bookCoverImageView.backgroundColor = .brown
    }
    
    // 이거 내일 할거!
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
