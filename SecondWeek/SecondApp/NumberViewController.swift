//
//  NumberViewController.swift
//  SecondApp
//
//  Created by 조우현 on 12/30/24.
//

import UIKit

class NumberViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 반환값이 없는경우
        // 1. 오늘 날짜를 가져오겠구나! => 유추 가능
        // 2. 오늘 날짜를 레이블에 보여주겠구나..? => 유추 불가능
        // => 오늘 날짜를 레이블 뿐 아니라 어디서든 사용하고 싶다 => 반환값 사용
        // getToday()
        
        // 반환값이 있는 경우
        // getToday()의 반환값을 resultLabel.text에 보여주겠구나! => 유추 가능
//        resultLabel.text = getToday()
        
        // 직접 만든 extension 사용
        setViewBackground()
        
        getToday()
        
        print(NSHomeDirectory())

        // UserDefaults에 저장된 데이터 불러오기
        let result = UserDefaults.standard.string(forKey: "number")
        
        numberTextField.text = result
    }

    func randomInt() -> Int {
        return Int.random(in: 1...100)
    }
    
    @discardableResult func getToday() -> String {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let today = format.string(from: Date())
        
        print(today)
        
        return today
    }
    
    // Editing Changed
    @IBAction func textFieldChanged(_ sender: Any) {
        // 실시간으로 레이블에 내용 반영
        // 입력한 내용이 숫자라면 숫자 그대로 출력
        // 입력한 내용이 문자라면 숫자가 아닙니다 출력
        
//        var textFieldtext = numberTextField.text
//
//        if let textFieldtext = Int(textFieldtext!) {
//            resultLabel.text = String(textFieldtext)
//        } else {
//            resultLabel.text = "숫자가 아닙니다."
//        }
        
        // 실시간으로 레이블에 내용 반영 확인
        // Optional String => String
        // UITextField의 text를 String 타입으로 변경
        guard let textFieldText = numberTextField.text else {
            print("옵셔널 오류")
            return
        }
        
        if let intText = Int(textFieldText) {
            resultLabel.text = "\(intText)"
        } else {
            resultLabel.text = "숫자가 아닙니다."
        }
        
        // guard문을 사용한다면?
//        guard let intText = Int(textFieldText) else {
//            resultLabel.text = "숫자가 아닙니다."
//            return
//        }
//
//        resultLabel.text = "\(intText)"
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 텍스트필드에 적었던 내용을 영구적으로 저장.
        UserDefaults.standard.set(numberTextField.text, forKey: "number")
        
        // 사용자에게 성공적으로 저장이 되었다는 알림을 주기
        // 1. 본문(타이틀 + 메세지)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 2. 버튼
        let okButton = UIAlertAction(title: "확인", style: .cancel)
        let testButton1 = UIAlertAction(title: "테스트1", style: .default)
        let testButton2 = UIAlertAction(title: "테스트2", style: .default)
        let testButton3 = UIAlertAction(title: "테스트3", style: .default)
        
        // 3. 본문에 버튼 추가: 순서대로 붙음
        alert.addAction(testButton3)
        alert.addAction(okButton)
        alert.addAction(testButton1)
        alert.addAction(testButton2)
        // 4. 화면에 띄우기
        present(alert, animated: true)
    }
}
