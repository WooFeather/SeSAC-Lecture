//
//  PhoneViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self, // 내 화면에서 내가 받을게
            selector: #selector(jackReceivedNotification), // 받으면 어떤 기능 실행할래
            name: NSNotification.Name("jack"), // 어떤 보따리의 신호를 받을거야?
            object: nil
        )
    }
    
    @objc func jackReceivedNotification(value: NSNotification) {
        // 이곳에 값 넣어주기
        if let name = value.userInfo!["value"] as? String {
            print(self, name)
        } else {
            print(self, "데이터 없음")
        }
    }
    
    deinit {
        print(self)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

