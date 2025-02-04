//
//  ExampleViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/4/25.
//

import UIKit

class User<T> {
    
    var myFunction: (() -> Void)?
    
    var value: T {
        didSet {
            myFunction?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}

class ExampleViewController: UIViewController {

    let jack = User(10)
    
    var nickname = "고래밥" {
        didSet {
            print("닉네임: \(nickname)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jack.value = 2
        jack.value = 3
        
        jack.myFunction = {
            print("VC에 있는 닉네임: \(self.nickname)")
            print("아무 기능...")
            print("네트워크 통신 기능...")
        }
        
        jack.value = 4
        
        
        
        
        print("닉네임: \(nickname)")
        
        nickname = "칙촉"
        
        nickname = "고구마"
        
        configureView()
        test()
        print("====")
        test2()
    }
    
    private func test2() {
        var num = Observable(3)
        
        num.bind { value in
            print(value)
        }
        
        num.value = 6
        num.value = 4
    }
    
    private func test() {
        var num = 3
        
        print(num)
        
        num = 6
        num = 4
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
}
