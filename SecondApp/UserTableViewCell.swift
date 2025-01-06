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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureData(row: Friends) {
        profileImageView.backgroundColor = .brown
        nameLabel.font = .boldSystemFont(ofSize: 30)
        messageLabel.font = .systemFont(ofSize: 20)
        
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
