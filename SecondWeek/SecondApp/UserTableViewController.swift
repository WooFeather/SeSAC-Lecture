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
        
        navigationItem.title = "타이틀"
        
        // 코드가 너무 길면 이렇게 하기도 함
        let star = UIImage(systemName: "star")
        let right = UIBarButtonItem(image: star, style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = right
        
        
//        // Xib cell
//        let nib = UINib(nibName: "NoProfileViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "NoProfileViewCell")
    }
    
    // 셀의 버튼과 다르게 항상 똑같은 버튼을 탭하는 거기 때문에 매개변수 안넣어줌
    @objc
    func rightButtonTapped() {
        // 1. (가지고 올 VC가 담겨있는)스토리보드 특정 ex. User
        let sb = UIStoryboard(name: "User", bundle: nil)
        
        // 같은 스토리보드에서 이동한다면 내가 속한 스토리보드를 확인하고 거기서 바로 작업 가능
        // 나 어떤 스토리보드에 속해있지? => User storyboard에 있다는 것을 앎
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GrayViewController") as! GrayViewController
        
        // 3. 화면을 전환할 방법 선택하기 - 우측에서 등장 / IB: show / 전제조건: Navi / Code: push
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
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
        
        // UserTableViewCell의 인스턴스
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        // 1. (가지고 올 VC가 담겨있는)스토리보드 특정 ex. User
        let sb = UIStoryboard(name: "User", bundle: nil)
        
        // 2. 전환할 뷰컨트롤러를 가져오기 ex. BrownVC
        let vc = sb.instantiateViewController(withIdentifier: "BrownViewController") as! BrownViewController
//        vc.testLabel.text = "고래밥"   // 값 전달할 땐 Outlet을 사용할 순 없음
        
        // 2. pass Data - vc가 갖고 있는 프로퍼티에 데이터 추가
        vc.contents = friends[indexPath.row].name
        
        // (옵션2) present이지만, navi title도 쓰고 싶다면, 다시 네비게이션 컨트롤러를 임베드해서, 네비게이션 컨트롤러를 present
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen // 아래에서 위로 뜰 때 방식
        nav.modalTransitionStyle = .crossDissolve  // 전환 애니메이션
        
        // 3. 화면을 전환할 방법 선택하기 - 아래에서 위로 / IB: modal / Code: present(Alert에서 사용한 메서드와 동일)
        present(nav, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
    
    // cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
