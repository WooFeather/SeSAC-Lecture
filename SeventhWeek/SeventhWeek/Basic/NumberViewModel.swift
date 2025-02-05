//
//  NumberViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class NumberViewModel {
    
    // 뷰컨에서 사용자에 의해 받아온 값 그 자체
    // 실시간으로 받아온 데이터를 didSet으로 대응하기 위해서 Field클래스 사용
    var inputField: Field<String?> = Field(nil) // Field("")로하면 "값을 입력해주세요"라는 텍스트가 뜸
    
    // VC의 레이블에 보여줄 최종 텍스트
    var outputText = Field("")
    
    // VC의 레이블 텍스트 컬러로 사용할 것 => 파랑(true), 빨강(false)
    var outputTextColor = Field(false)
    
    // input이 nil이라서 init에 매개변수 없어도 ㄱㅊ
    // VC에서 NumberViewModel 클래스의 인스턴스가 생성이 될 때 초기화
    init() {
        print("NumberViewModel")
        
        // bind는 실행시점이 늦어질수록 제대로 동작을 안할수도 있어서 초기화시점에 실행
        inputField.bind { text in // text는 VC에서 amountTextField.text의 값이 value를 통해 들어온 것
            print("inputField", text ?? "")
            self.validation()
        }
    }
    
    private func validation() {
        // 1) 옵셔널에 대한 핸들링
        guard let text = inputField.value else {
            outputText.value = ""
            outputTextColor.value = false
            return
        }
        
        // 2) empty값 대응
        if text.isEmpty {
            outputText.value = "값을 입력해주세요"
            outputTextColor.value = false
            return // guard문이 아니더라도 early exit 가능(다음 코드를 실행x)
        }
        
        // 3) 숫자여부 파악
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요"
            outputTextColor.value = false
            return
        }
        
        // 4) 0 ~ 1,000,000 사이의 범위 지정
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)! // formatting된 숫자를 문자로 변환
            outputText.value = "￦" + result
            outputTextColor.value = true
        } else {
            outputText.value = "백만원 이하의 금액을 입력해주세요"
            outputTextColor.value = false
        }
    }
}
