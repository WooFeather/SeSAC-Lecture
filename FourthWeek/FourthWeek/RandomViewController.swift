//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

struct User: Decodable {
    let results: [UserDetail]
}

struct UserDetail: Decodable {
    let gender: String
    let email: String
    let name: UserName
}

struct UserName: Decodable {
    let first: String
    let last: String
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}

struct Dog: Decodable {
    let message: String
    let status: String
}

// 클래스에서만 사용되도록 제약사항 설정 => AnyObject(예전엔 class라고 쓰기도 했음)
protocol ViewConfiguration: AnyObject {
    func configureHierarchy() // addSubView
    func configureLayout() // snapKit
    func configureView() // property
}

class RandomViewController: UIViewController, ViewConfiguration {
    
    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    let randomButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configureLayout() {
        dogImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
        }
        
        randomButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        randomButton.backgroundColor = .brown
        randomButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        print("======1111111======")
        // 버튼 누르면 랜덤으로 강아지 나오게
        // 크옴에서 엔터키 눌렀을 때처럼 요청하는 부분
        
        let url = "https://dog.ceo/api/breeds/image/random"
        // method: 프로퍼티는 .get이 기본값 => get일경우에 안써줘도 됨
        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
            
            print("======2222222======")
            
            switch response.result {
            case .success(let value):   // 응답, 식판 => 구조체를 활용할 수 있다
                print("SUCCESS")
                // AF구문 안에서, nameLabel이라는걸 다른데서 쓰고있을수도 있기 때문에
                // 내가 만든 nameLabel을 쓸거야! 라는 의미로 self를 써줘야 함
                self.nameLabel.text = value.message
                // KF로 이미지 불러와보기
                
            case .failure(let error):
                print("ERROR")
                print(error)
            }
            
            print("======3333333======")
            
        }
        
        print("======4444444======")
    }
    
    @objc
    func lottoButtonTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(Int.random(in: 800...1154))"
        
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            
            print("======2222222======")
            
            switch response.result {
            case .success(let value):   // 응답, 식판 => 구조체를 활용할 수 있다
                print("SUCCESS")
                // AF구문 안에서, nameLabel이라는걸 다른데서 쓰고있을수도 있기 때문에
                // 내가 만든 nameLabel을 쓸거야! 라는 의미로 self를 써줘야 함
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
                // KF로 이미지 불러와보기
                
            case .failure(let error):
                print("ERROR")
                print(error)
            }
            
            print("======3333333======")
            
        }
    }
    
    @objc
    func userButtonTapped() {
        let url = "https://randomuser.me/api/?results=10"
        
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.nameLabel.text = value.results[0].name.first
            case .failure(let error):
                print("ERROR")
                print(error)
            }
        }
    }
}
