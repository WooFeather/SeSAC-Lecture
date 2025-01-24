//
//  PosterViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/24/25.
//

import UIKit

class PosterViewController: UIViewController {

    lazy private var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
    var list = ["test1", "test2", "test3"]
    
    var detailList1 = ["star.fill", "pencil", "xmark", "heart"]
    var detailList2 = ["pencil", "xmark", "heart"]
    var detailList3 = ["star", "pencil", "xmark", "heart.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        
        cell.titleLabel.text = list[indexPath.row]
        cell.collectionView.backgroundColor = .green
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        
        return cell
    }
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return detailList1.count
        } else if collectionView.tag == 1 {
            return detailList2.count
        } else {
            return detailList3.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        
        
        if collectionView.tag == 0 {
            let data = detailList1[indexPath.item]
            cell.posterImageView.image = UIImage(systemName: data)
        } else if collectionView.tag == 1 {
            let data = detailList2[indexPath.item]
            cell.posterImageView.image = UIImage(systemName: data)
        } else {
            let data = detailList3[indexPath.item]
            cell.posterImageView.image = UIImage(systemName: data)
        }
        
        return cell
    }
}
