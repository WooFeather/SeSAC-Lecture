//
//  UserTableViewCell.swift
//  SecondApp
//
//  Created by 조우현 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    // 스토리보드 파일이 있을때만 실행
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        
        configure()
    }
    
    func configure() {
        profileImageView.backgroundColor = .brown
        nameLabel.font = .boldSystemFont(ofSize: 30)
        messageLabel.font = .systemFont(ofSize: 20)
    }
    
    func configureData(row: Friends) {
        print(#function)
        
        nameLabel.text = row.name
        messageLabel.text = row.message
        
        let image = row.profile_image
        if let image {
            let url = URL(string: image)
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: "person")
        }
        
        let name = row.like ? "heart.fill" : "heart"
        let btn = UIImage(systemName: name)
        likeButton.setImage(btn, for: .normal)
    }
}
