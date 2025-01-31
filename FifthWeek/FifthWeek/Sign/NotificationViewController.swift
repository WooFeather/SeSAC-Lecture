//
//  NotificationViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/23/25.
//

import UIKit
import SnapKit

extension NSNotification.Name {
    static let myName = NSNotification.Name("myName")
}

class NotificationViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "노티피케이션을 통한 값전달")
    let nextButton = PointButton(title: "저장하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sesacRecived),
            name: NSNotification.Name("sesac"),
            object: nil
        )
    }
    
    @objc func sesacRecived() {
        print(#function)
    }
    
    @objc func nextButtonClicked() {
        // Notification을 통해 값을 보내기
        NotificationCenter.default.post(
            name: .myName, // 보따리 이름 뭘로지을래
                object: nil,
                userInfo: [ // 어떤 정보들을 전달할래?
                    "nickname": "하이",
                    "value": emailTextField.text!
                ]
        )
        
        navigationController?.popViewController(animated: true)
    }
    
    func configureLayout() {
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
