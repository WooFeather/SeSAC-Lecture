//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
   
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
    let profileButton = PointButton(title: "프로필")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        profileButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        
        // Notification
        NotificationCenter.default.addObserver(
            self, // 내 화면에서 내가 받을게
            selector: #selector(jackReceivedNotification), // 받으면 어떤 기능 실행할래
            name: NSNotification.Name("jack"), // 어떤 보따리의 신호를 받을거야?
            object: nil
        )
    }
    
    @objc func jackReceivedNotification(value: NSNotification) {
        // 이곳에 값 넣어주기
        statusLabel.text = "6566565"
        if let name = value.userInfo!["value"] as? String {
            print(self, name)
            statusLabel.text = name
        } else {
            statusLabel.text = "데이터가 안왔음"
        }
    }
    
    deinit {
        print(self)
    }
    
    @objc func profileButtonClicked() {
        let vc = NotificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextButtonClicked() {
        let vc = EmailViewController()
        navigationController?.pushViewController(vc, animated: true)
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first else { return }
//        
//        window.rootViewController = UINavigationController(
//            rootViewController: EmailViewController()
//        )
//        window.makeKeyAndVisible()
    }
    
    func configureLayout() {
        view.addSubview(statusLabel)
        view.addSubview(nextButton)
        view.addSubview(profileButton)
         
        statusLabel.text = "메인 화면"
        
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

