//
//  DelegateViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/23/25.
//

import UIKit

class DelegateViewController: UIViewController {

    private let emailTextField = SignTextField(placeholderText: "딜리게이트를 통한 값전달")
    private let nextButton = PointButton(title: "저장하기")
    
    var contents: PassDataDelegate? // 이제 이 프로토콜을 채택한 클래스든 구조체든 다 들어올 수 있다
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc private func nextButtonClicked() {
        print(#function)
        // contents?(emailTextField.text!)
        
        // 동일한 인스턴스의 MainVC를 어떻게 가지고오지?
        // MainViewController().nicknameReceived()
        contents?.nicknameReceived(value: emailTextField.text!)
        
        navigationController?.popViewController(animated: true)
    }

    private func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
         
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
