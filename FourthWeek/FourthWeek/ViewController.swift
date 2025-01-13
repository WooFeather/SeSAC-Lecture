//
//  ViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/13/25.
//

// Right To Left, Left to Right

import UIKit
import SnapKit

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
    let nameTextField = UITextField()
    
    let redView = UIView()
    let greenView = UIView()
    let grayView = UIView()
    
    lazy var button = {
        print("Button Button Button")
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
    @objc
    func nextButtonTapped() {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        buttonConfig()
        layoutAnchor()
        autoLayoutConstraints()
        frameBasedLayout()
//        autoLayoutSnapKit()
        autoLayoutSnapKit2()
    }
    
    func buttonConfig() {
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func autoLayoutSnapKit2() {
        view.addSubview(redView)
        view.addSubview(grayView)
        redView.addSubview(greenView)
        
        redView.backgroundColor = .red
        grayView.backgroundColor = .gray
        greenView.backgroundColor = .green
        
        redView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        
        greenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        grayView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(50)
        }
    }
    
    func autoLayoutSnapKit() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(grayView)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
        
        redView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50)
//            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        
        greenView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(50)
            make.centerX.equalTo(greenView.snp.centerX).offset(-100)
            make.size.equalTo(200)
        }
    }
    
    func layoutAnchor() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        nameTextField.backgroundColor = .green
    }
    
    func frameBasedLayout() {
        // 2. addSubview로 뷰 추가
        view.addSubview(emailTextField)
        
        // 3. 뷰객체의 위치와 크기 설정
        emailTextField.frame = CGRect(x: 50, y: 100, width: 293, height: 50)
        // 4. 뷰 속성 조절
        emailTextField.backgroundColor = .lightGray
    }
    
    func autoLayoutConstraints() {
        view.addSubview(passwordTextField)
        // 오토리사이징으로 제약사항 잡을겨? => 아뇨 저는 오토레이아웃으로 할건데요
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 50)
        
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        
        view.addConstraints([top, leading, trailing, height])
        
        passwordTextField.backgroundColor = .red
    }
}

