//
//  TenViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/7/25.
//

import UIKit

// 왜 여기서는 CellForRowAt이 안나올까?
// 테이블뷰 아웃렛
// 테이블뷰를 만들 때 필요한 것들이 있는데 -> 이거 수동으로 다 해줘야ㅕ 함
// => 프로토콜 / 딜리게이트

/*
 1. 이름!
 2. 테이블뷰 부하직원! (프로토콜)
 3. 필수 기능
 4. 테이블뷰와 부하직원이 서로 연결(=타입으로서의 프로토콜, Protocol as Type)
 */

//                                          2. 테이블뷰 부하직원! (프로토콜)
class TenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var searchBar: UISearchBar!
    // 1. 이름 지어주기
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        // xib 셀을 가져와서 사용
        let xib = UINib(nibName: "NoProfileViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "NoProfileViewCell")
        tableView.rowHeight = 100
        
        // 4. 테이블뷰와 부하직원이 서로 연결(=타입으로서의 프로토콜, Protocol as Type)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 3. 필수 기능(1)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 10
    }
    
    // 3. 필수 기능(2)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileViewCell", for: indexPath) as! NoProfileViewCell
        print(#function)
        
        cell.backgroundColor = .lightGray
        
        return cell
    }
}
