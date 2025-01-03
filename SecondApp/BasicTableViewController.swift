//
//  BasicTableViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/2/25.
//

import UIKit

class BasicTableViewController: UITableViewController {
    
    var list = ["프로젝트", "메인 업무", "새싹 과제", "코코딩딩"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Monster 클래스 안에 있는 모든 정보를 가져와서 monster에 저장하겠다!
        // => 초기화를 한다 즉, 인스턴스를 생성했다!
//        var monster = Monster()
        
        
        tableView.rowHeight = 80
    }
    
    @IBAction func randomButtonTapped(_ sender: UIBarButtonItem) {
        let randomItems = ["장보기", "영화보기", "쇼핑하기", "맛집탐방", "티비보기", "야구보기"]
        
        let value = randomItems.randomElement()!
        print("Before", list)
        list.append(value)
        print("After", list)
        
        // 뷰와 데이터는 따로 놀아서, 늘 잘 맞춰주어야 한다
//        tableView.reloadData()
    }
    
    // 1. 셀의 갯수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count
    }
    
    // 2. 셀 디자인 및 데이터 처리: cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wooCell")!
        
        // textLabel은 subtitle style에서 Title에 해당하는 애
        // detailTextLabel은 subtitle style에서 Subtitle에 해당하는 애
        // cell이 옵셔널인 이유: identifire를 잘못 입력해서, 구분자를 찾을 수 없을 때를 대비
        // 위의dequeueReusableCell 부분에 !를 치면 됨
        // textLabel이 옵셔널인 이유: Style에 따라 없을수도 있는 텍스트
        cell.textLabel?.text = "텍스트 레이블"
        
        // extension 활용!
        cell.detailTextLabel?.setPrimaryLabel("디테일 텍스트 레이블")
        setLabel(cell.detailTextLabel!, text: "디테일 텍스트 레이블")
        
        cell.textLabel?.text = list[indexPath.row]
        
//        cell.detailTextLabel?.text = "디테일 텍스트 레이블"
        
        cell.textLabel?.textColor = .red
        cell.textLabel?.font = .systemFont(ofSize: 30)
        
        // 3번 이하 인덱스에 대해서 회색 변경
//        if indexPath.row < 3 {
//            cell.backgroundColor = .gray
//        } else {
//            cell.backgroundColor = .white
//        }
        
//        if indexPath.row <= 3 {
//            cell.backgroundColor = .gray
//        }
        
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .gray
        } else {
            cell.backgroundColor = .white
        }
        
        // 셀의 개수만큼 실행됨
        print(#function, indexPath)
        return cell
    }
    
    // 셀을 탭했을때의 동작
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        // row의 인덱스 == list의 인덱스 이기 때문
        list.remove(at: indexPath.row)
//        tableView.reloadData()
    }
    
//    // 3. 셀의 높이: heightForRowAt
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        print(#function, indexPath.row)
//        return 80
//    }
}
