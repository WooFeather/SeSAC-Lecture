//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

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
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func randomButtonTapped() {
        // 버튼 누르면 랜덤으로 강아지 나오게
        // 크옴에서 엔터키 눌렀을 때처럼 요청하는 부분
        
        let url = "https://dog.ceo/api/breeds/image/random"
        // method: 프로퍼티는 .get이 기본값 => get일경우에 안써줘도 됨
        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
            switch response.result {
            case .success(let value):
                print(value.message)
                print(value.status)
            case .failure(let error):
                print(error)
            }
        }
    }
}
