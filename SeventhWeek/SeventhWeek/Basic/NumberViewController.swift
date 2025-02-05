//
//  NumberViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

// 5. 다양한 타입이 value의 값으로 들어올 수 있도록 제네릭으로 수정
class Field<T> {
    
    // 3. closure를 사용하는 방식으로 수정
    private var closure: ((T) -> Void)?
    
    // 2. didSet을 활용해서 값이 변경될 때 신호를 받음
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    // 1. init을 작성 (외부매개변수명 생략)
    init(_ value: T) {
        self.value = value
    }
    
    // 4. 값이 변경되었을 때 뿐 아니라 초기값(init)일때도 동일한 동작을 하기 위해 bind()라는 메서드 생성
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
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
       
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // bind는 didSet의 동작을 한다고 생각하면 됨
        // outputText 값이 바뀌면 어떤 동작을 할거야?
        viewModel.outputText.bind { text in
            print("outputText", text)
            self.formattedAmountLabel.text = text
        }
        
//        let a = Field("고래밥")
//        
//        a.bind { example in
//            print("이름 변경되었음: \(example)")
//            self.navigationItem.title = example
//        }
//        
//        a.value = "칙촉"
//        a.value = "카스타드"
        
        configureUI()
        configureConstraints()
        configureActions()
    }
 
    @objc private func amountChanged() {
        print(#function)
        
        // VC는 text를 그냥 VM로 넘겨줄 뿐, 그 안에서의 동작은 알 지 못함
        viewModel.inputField.value = amountTextField.text
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
