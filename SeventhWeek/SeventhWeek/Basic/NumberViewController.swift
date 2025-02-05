//
//  NumberViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

class Jack {
    
    // 3. closure를 사용하는 방식으로 수정
    private var closure: ((String) -> Void)?
    
    // 2. didSet을 활용해서 값이 변경될 때 신호를 받음
    var name: String {
        didSet {
            closure?(name)
        }
    }
    
    // 1. init을 작성 (외부매개변수명 생략)
    init(_ name: String) {
        self.name = name
    }
    
    // 4. 값이 변경되었을 때 뿐 아니라 초기값(init)일때도 동일한 동작을 하기 위해 bind()라는 메서드 생성
    func bind(test: @escaping (String) -> Void) {
        test(name)
        closure = test
    }
}

class NumberViewController: UIViewController {

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = Jack("고래밥")
        
        a.bind { example in
            print("이름 변경되었음: \(example)")
            self.navigationItem.title = example
        }
        
        a.name = "칙촉"
        
        a.name = "카스타드"
        
        
        
        
        configureUI()
        configureConstraints()
        configureActions()
    }
 
    @objc private func amountChanged() {
        print(#function)
        // 로직     =>      뷰
        // 공백일 때 => 값을 입력해주세요
        // 숫자가 아닐 때 => 숫자를 입력해주세요
        // 숫자 범위 설정 => 100만원 이하의 값을 작성해주세요
        // 올바른 값일 때 콤마찍어주기 => 1,234,456
        formattedAmountLabel.text = amountTextField.text
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }

    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }

}
