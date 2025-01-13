//
//  ViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/13/25.
//

import UIKit

/*
 1. 스토리보드에서 객체 얹기
 2. 객체 레이아웃 잡기
 3. 아웃렛 연결하기
 4. 객체 속성 코드로 조절하기
 */
class ViewController: UIViewController {
    
    // 1. 뷰 객체 프로퍼티 선언
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(passwordTextField)
        // 오토리사이징으로 제약사항 잡을겨? => 아뇨 저는 오토레이아웃으로 할건데요
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 50
        )
        
        // top 레이아웃을 적용해주세요
        top.isActive = true
        
        NSLayoutConstraint(
            item: passwordTextField,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 40
        ).isActive = true
        
        NSLayoutConstraint(
            item: passwordTextField,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: -40
        ).isActive = true
        
        NSLayoutConstraint(
            item: passwordTextField,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 50
        ).isActive = true
        
        passwordTextField.backgroundColor = .red
        
//        frameBasedLayout()
    }
    
    func frameBasedLayout() {
        // 2. addSubview로 뷰 추가
        view.addSubview(emailTextField)
        
        // 3. 뷰객체의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 293, height: 50)
        // 4. 뷰 속성 조절
        emailTextField.backgroundColor = .lightGray
    }
}

