//
//  NicknameViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
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
        // 뒤로 돌아가면 안되니까
        // window의 rootViewController를 교체
        
        // scene & window를 어떻게 가져올까?
        
        // UIApplication.shared.windows.first 예전에 쓰던 코드 -> deprecated
        
        // UIApplication에서 windowScene을 가져오기 + 그중에서 첫 번째 scene을 가져오는 것 => extension으로 빼놓기
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first else { return }
//        
//        window.rootViewController = UINavigationController(
//            rootViewController: MainViewController()
//        )
//        window.makeKeyAndVisible()
        
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

