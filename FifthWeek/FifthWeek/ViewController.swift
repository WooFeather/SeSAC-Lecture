//
//  ViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/20/25.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
/*
 1. GCD vs SwiftConcurrency
    - GCD: sync/async/serial/concurrent -> dispatchGroup
 2. url관리 AF구문코드 관리
    - router pattern
 */
class ViewController: UIViewController {

    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    let checkButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
//        concurrentAsync()
//        concurrentSync()
        serialAsync()
//        serialSync()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
    }
    
    func concurrentAsync() {
        print("🔵START", terminator: " ")
        
        for item in 1...100 {
            DispatchQueue.global().async {
                print(item, terminator: " ")
            }
        }
        
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        print("END🔴", terminator: " ")
    }
    
    func concurrentSync() {
        print("🔵START", terminator: " ")
        
        DispatchQueue.global().sync {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        print("END🔴", terminator: " ")
    }
    
    func serialAsync() {
        print("🔵START", terminator: " ")
        
        DispatchQueue.main.async {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        print("END🔴", terminator: " ")
    }
    
    func serialSync() {
        print("🔵START", terminator: " ")
        
        for item in 1...100 {
            print(item, terminator: " ")
        }
        
        // 무한 대기 상태. 교착 상태 / DeadLock
//        DispatchQueue.main.sync {
            for item in 101...200 {
                print(item, terminator: " ")
            }
//        }
        
        print("END🔴", terminator: " ")
    }

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(firstImageView)
        view.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func checkButtonTapped() {
        
        print(#function)
        // "https://picsum.photos/200/200"
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/sombrero_spitzer_3000.jpg")!
        
        // 다른 알바생: 네트워크 통신, 파일 다운로드
        // 이 블럭 안에 들어가는 친구는 메인이 아닌 다른친구가 일함
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    // UI를 그려주는 일은 main한테 다시 넘겨주기
                    DispatchQueue.main.async {
                        self.firstImageView.image = image
                    }
                }
            }
        }
    }
}
