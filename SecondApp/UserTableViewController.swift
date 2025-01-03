//
//  UserTableViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewController: UITableViewController {
    
    let friends = FriendsInfo().list

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // cell의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // cell의 디자인과 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 이번에 for을 쓴 이유: custom cell이기 때문에 어떤 위치의 cell인지 확인하기 위함
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        // 반복되는 코드를 row로 만들어놓음
        let row = friends[indexPath.row]
        
        cell.profileImageView.backgroundColor = .brown
        
        // kf와 옵셔널 처리
        let image = row.profile_image
        
        if let image {
            let url = URL(string: image)
            cell.profileImageView.kf.setImage(with: url)
        } else {
            cell.profileImageView.image = UIImage(systemName: "person")
        }
        
        cell.nameLabel.text = row.name
        cell.messageLabel.text = row.message
        
        cell.nameLabel.font = .boldSystemFont(ofSize: 30)
        cell.messageLabel.font = .systemFont(ofSize: 20)
        
        // 좋아요 버튼의 이미지
        let name = row.like ? "heart.fill" : "heart"
        let btn = UIImage(systemName: name)
        cell.likeButton.setImage(btn, for: .normal)
        
        return cell
    }
    
    // cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
