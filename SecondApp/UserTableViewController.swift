//
//  UserTableViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/3/25.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var friends = FriendsInfo().list

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Xib cell
//        let nib = UINib(nibName: "NoProfileViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "NoProfileViewCell")
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        
        // 원래는 indexPath.row를 이용하고 싶었는데 그 매개변수는 cellForRowAt함수에서 사용 가능
        // 여기서는 마침 sender.tag와 값이 일치하기 때문에, 해당 값을 사용
        friends[sender.tag].like.toggle()
        print(friends[sender.tag].like)
        
        // 잊지말자 reloadData!! 데이터와 뷰는 따로논다!!!!!!!!!!!!!!
//        tableView.reloadData()
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
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
        
        cell.configureData(row: row)
        
        // 좋아요 버튼에 액션 지정
        // 1. 버튼을 구분짓기 위해서 tag를 분류
        cell.likeButton.tag = indexPath.row
        // 2. IBAction 대신 코드로 액션 연결
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    // cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
