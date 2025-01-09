//
//  TenCollectionViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/7/25.
//

import UIKit

//                                                  2. 부하직원데려오기
class TenCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 1. 이름 지어주기
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "TenCollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "TenCollectionViewCell")
        
        // 4. 부하직원하고 연결
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20 // 셀의 아래위 간격
        layout.minimumInteritemSpacing = 20 // 셀의 양 옆 간격
        layout.sectionInset = UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50)
        
        collectionView.collectionViewLayout = layout
    }
    
    // 3. 필수 기능(1)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // 3. 필수 기능(2)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TenCollectionViewCell", for: indexPath)
        
        return cell
    }
}
