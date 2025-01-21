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
        
        
        example3()
//        example2()
//        example()
//        concurrentAsync()
//        concurrentSync()
//        serialAsync()
//        serialSync()
    }
    
    func example3() {
        print("🔵START", terminator: " ")
        
        // DeadLock
//        DispatchQueue.main.sync {
//            for item in 1...10 {
//                print(item, terminator: " ")
//            }
//        }
        
        // serial async => 맨 마지막에 실행될듯 🅾️
        DispatchQueue.main.async {
            for item in 11...20 {
                print(item, terminator: " ")
            }
        }
        
        
        // concurrent sync => 출력순서는 serial sync와 같을것이고, main이 아무일도 안하기 때문에 잘 사용하지 않음 🅾️
        DispatchQueue.global().sync {
            for item in 21...30 {
                print(item, terminator: " ")
            }
        }
        
        // 다른 스레드로 보낸 상태에서 concurrent sync => 순서가 섞여서 나올듯 🅾️
        // 이 숫자뭉치는 섞여서 나오지만(어느 시점에든 들어감), 31~40 순서는 유지됨
        DispatchQueue.global().async {
            DispatchQueue.global().sync {
                for item in 31...40 {
                    print(item, terminator: " ")
                }
            }
        }
        
        // 이중 concurrent async => 숫자뭉치, 숫자뭉치 내 전부 섞여서 나올듯 ❎
        // 숫자뭉치는 다른 숫자들 사이에 섞여서 나오지만, 41~50 사이의 숫자는 순서대로 나옴
        DispatchQueue.global().async {
            DispatchQueue.global().async {
                for item in 41...50 {
                    print(item, terminator: " ")
                }
            }
        }
        
        // concurrent async => 숫자뭉치는 다른 숫자들 사이에 섞이고, 순서는 지켜질것 🅾️
        DispatchQueue.global().async {
            for item in 51...60 {
                print(item, terminator: " ")
            }
        }
        
        // for문 두개를 감싼 concurrent async => 숫자뭉치는 다른 숫자들 사이에 섞이고, 순서(61~80)는 지켜질것 🅾️
        DispatchQueue.global().async {
            for item in 61...70 {
                print(item, terminator: " ")
            }
            
            for item in 71...80 {
                print(item, terminator: " ")
            }
        }
        
        // concurrent async 안의 serial async => 91-100 숫자뭉치는 섞이지 않고 그대로 출력, 그러나 두 숫자뭉치 모두 그 위치 자체는 섞임 ❎
        // 81-90은 순서는 지켜지고 위치가 섞인것은 맞지만, 91-100 뭉치는 순서는 유지, 그리고 위치는 항상 맨 마지막에 출력임
        DispatchQueue.global().async {
            for item in 81...90 {
                print(item, terminator: " ")
            }
            
            DispatchQueue.main.async {
                for item in 91...100 {
                    print(item, terminator: " ")
                }
            }
        }
        
        // 이중 serial async => 이 두 숫자뭉치는 맨 마지막에 출력될것이고, 그중에서 101-110이 더 마지막에 출력될듯 ❓
        // 일단 101~110이 맨 마지막에 출력되는건 맞지만, 111~120이 출력되고 그 다음에 91~100이 먼저 출력되고 101~110이 맨 마지막
        // 111~120과 91~100의 순서는 어떻게 결정되지?
        // 실행되면 이 두개의 반복문은 즉시 맨 뒤로감 -> 91-100반복문은 일단 다른 스레드로 갔다가 맨 뒤로 옴 -> 그중 101-110반목문은 맨 뒤로 감
        // 그래서 111-120 -> 91-100 -> 101-110인듯
        DispatchQueue.main.async {
            DispatchQueue.main.async {
                for item in 101...110 {
                    print(item, terminator: " ")
                }
            }
            
            for item in 111...120 {
                print(item, terminator: " ")
            }
        }
        
        // attributes를 지정해주지 않는다면 기본적으로 Serial, qos도 지정할 수 있음
        let customQueue = DispatchQueue(label: "serial async")
        
        // custom serial async 안의 serial sync => 맨 마지막에 실행 🅾️
        // 일단 커스텀 큐로 보내지고, 121-130은 다른 작업이 끝날때까지 기다릴것
        customQueue.async {
            DispatchQueue.main.sync {
                for item in 121...130 {
                    print(item, terminator: " ")
                }
            }
        }
        
        let customQueue2 = DispatchQueue(label: "concurrent async", attributes: .concurrent)
        
        // custom concurrent async 안의 serial sync => 얘도 아마 맨 마지막에 실행..? 🅾️
        // 역시 일단 커스텀 큐로 보내지고, 131-140은 다른 작업이 끝날때까지 기다릴것
        customQueue2.async {
            DispatchQueue.main.sync {
                for item in 131...140 {
                    print(item, terminator: " ")
                }
            }
        }
        
        // custom serial async안의 concurrent async => 151-160은 순서대로, 161-170은 순서는 지키되 위치는 무작위 ❎
        // 151-170 전부 맨 마지막에 실행되고 순서도 지켜짐...
        customQueue.async {
            for item in 151...160 {
                print(item, terminator: " ")
            }
            
            DispatchQueue.global().async {
                for item in 161...170 {
                    print(item, terminator: " ")
                }
            }
        }
        
        // custom concurrent async 안의 concurrent async => 두 숫자뭉치의 순서는 유지, 위치는 무작위 ❎
        // 둘 다 순서 지켜서 차례대로
        customQueue2.async {
            for item in 171...180 {
                print(item, terminator: " ")
            }
            
            DispatchQueue.global().async {
                for item in 181...190 {
                    print(item, terminator: " ")
                }
            }
        }
        
        print("END🔴", terminator: " ")
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
    
    
    // DispatchGroup
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
