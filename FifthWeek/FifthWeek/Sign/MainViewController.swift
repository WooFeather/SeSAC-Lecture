//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

protocol PassDataDelegate {
    func nicknameReceived(value: String)
}

class MainViewController: UIViewController {
   
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
    let profileButton = PointButton(title: "프로필")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        profileButton.addTarget(self, action: #selector(delegateButtonClicked), for: .touchUpInside)
        
        // Notification을 통해 값을 받기
        NotificationCenter.default.addObserver(
            self, // 내 화면에서 내가 받을게
            selector: #selector(closureButtonClicked), // 받으면 어떤 기능 실행할래
            name: NSNotification.Name("jack"), // 어떤 보따리의 신호를 받을거야?
            object: nil
        )
    }
    
    @objc func delegateButtonClicked() {
        let vc = DelegateViewController()
        vc.contents = self // 현재 내 클래스 그 자체를 넣어줌!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func closureButtonClicked() {
        let vc = ClosureViewController()
        vc.contents = { value in
            print("테스트 티비")
            self.statusLabel.textColor = .blue
            self.statusLabel.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
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
        // 정방향으로 값 전달해보기
        NotificationCenter.default.post(
                name: NSNotification.Name("sesac"),
                object: nil,
                userInfo: [
                    "myData": statusLabel.text!
                ]
        )
        
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

extension MainViewController: PassDataDelegate {
    func nicknameReceived(value: String) {
        statusLabel.text = value
    }
}
