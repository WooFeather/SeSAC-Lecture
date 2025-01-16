//
//  BookView.swift
//  FourthWeek
//
//  Created by 조우현 on 1/16/25.
//

import UIKit
import SnapKit

class BookView: BaseView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func configureHierarchy() {
        // 원래 BookVC에 있을땐 view.addSubview(collectionView) 였는데, 여긴 view라서 self로 하거나 없어도됨
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        // 원래 BookVC에 있을땐 view.backgroundColor = .white 였는데, 여긴 view라서 self로 하거나 없어도됨
        backgroundColor = .white
        
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
    }
}
