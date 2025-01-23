//
//  ClosureViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/23/25.
//

import UIKit
import SnapKit

class ClosureViewController: UIViewController {

    private let emailTextField = SignTextField(placeholderText: "클로저를 통한 값전달")
    private let nextButton = PointButton(title: "저장하기")
    
    var contents: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        
//        emailTextField.text = contents
    }
    
    @objc private func nextButtonClicked() {
        // 클로저를 통한 값 보내기
        print(#function)
        contents?(emailTextField.text!)
        navigationController?.popViewController(animated: true)
    }

    private func configureLayout() {
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
