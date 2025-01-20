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
    
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
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
        
        example2()
//        example()
//        concurrentAsync()
//        concurrentSync()
//        serialAsync()
//        serialSync()
    }
    
    // DispatchGroup
    func example2() {
        print("START")
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        print("===1111===")
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("===2222===")
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
        
        // 보통 UI 업데이트를 여기서 함 => 그래서 queue를 .main으로 하
        // Topic의 경우 동시에 갱신을 하고싶을때 이곳에서 함
        group.notify(queue: .main) {
            print("알바생 3명 끝! 신호받음!!")
        }
    }
    
    func example() {
        print("START")
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        print("===1111===")
        DispatchQueue.global(qos: .background).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("===2222===")
        DispatchQueue.global().async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
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
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(firstImageView.snp.bottom).offset(20)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(secondImageView.snp.bottom).offset(20)
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func checkButtonTapped() {
        
        /*
         작업이 빠르게 끝날 수 있음
         여러 작업이 모두 종료되었다는 신호를 받기가 어렴
         */
        
        let group = DispatchGroup()
        
        group.enter() // +1
        NetworkManager.shared.fetchImage { image in
            print("firstImageView Succeed")
            group.leave() // -1
        }
        
        group.enter() // +1
        NetworkManager.shared.fetchImage { image in
            print("secondImageView Succeed")
            group.leave() // -1
        }
        
        group.enter() // +1
        NetworkManager.shared.fetchImage { image in
            print("thirdImageView Succeed")
            group.leave() // -1
        }
        
        group.notify(queue: .main) {
            print(#function, "END🔴")
        }
    }
}
