//
//  UserTableViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/3/25.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    let name = ["고래밥", "칙촉", "카스타드"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // cell의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    // cell의 디자인과 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 이번에 for을 쓴 이유: custom cell이기 때문에 어떤 위치의 cell인지 확인하기 위함
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        cell.profileImageView.backgroundColor = .brown
        cell.nameLabel.text = name[indexPath.row]
        cell.messageLabel.text = "상태메세지"
        
        cell.nameLabel.font = .boldSystemFont(ofSize: 30)
        cell.messageLabel.font = .systemFont(ofSize: 20)
        
        return cell
    }
    
    // cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
