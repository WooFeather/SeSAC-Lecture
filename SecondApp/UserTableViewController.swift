//
//  UserTableViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/3/25.
//

import UIKit

struct Friend {
    let name: String
    let message: String
    let profile_image: String
}

class UserTableViewController: UITableViewController {
    
    let friends = [
        Friend(name: "고래밥", message: "안녕하세요", profile_image: "star"),
        Friend(name: "칙촉", message: "오늘 너무 추워요", profile_image: "pencil"),
        Friend(name: "카스타드", message: "메롱티비", profile_image: "star.fill")
    ]
    
//    let name = ["고래밥", "칙촉", "카스타드"]
//    let message = ["안녕하세요", "오늘 너무 추워요", "메롱티비"]
//    let profile = ["star", "pencil", "star.fill"]

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
        
        cell.profileImageView.backgroundColor = .brown
        
        let image = friends[indexPath.row].profile_image
        cell.profileImageView.image = UIImage(systemName: image)
        
        cell.nameLabel.text = friends[indexPath.row].name
        cell.messageLabel.text = friends[indexPath.row].message
        
        cell.nameLabel.font = .boldSystemFont(ofSize: 30)
        cell.messageLabel.font = .systemFont(ofSize: 20)
        
        return cell
    }
    
    // cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
