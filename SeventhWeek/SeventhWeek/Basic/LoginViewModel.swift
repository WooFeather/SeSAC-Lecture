//
//  LoginViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class LoginViewModel {
    
    // VC에서 실시간으로 달라지는 textField의 값을 전달받아옴
    let inputID: Field<String?> = Field(nil)
    let inputPassword: Field<String?> = Field(nil)
    
    // 유효성 검증을 마친 텍스트를 VC로 보내기
    let outputValidText = Field("")
    // 버튼의 enabled상태 관리
    let outputValidButton = Field(false)
    
    init() {
        inputID.bind { _ in
            print("inputID Bind")
            self.validation()
        }
        
        inputPassword.bind { _ in
            print("inputPassword Bind")
            self.validation()
        }
    }
    
    private func validation() {
        
        // 1) 옵셔널 먼저 풀어주기
        guard let id = inputID.value,
        let pw = inputPassword.value else {
            outputValidText.value = "nil입니당"
            outputValidButton.value = false
            return
        }
        
        // 2) 글자수 체크하기
        if id.count >= 4 && pw.count >= 4 {
            outputValidText.value = "굿~"
            outputValidButton.value = true
        } else {
            outputValidText.value = "아이디, 비밀번호는 4자리 이상입니다."
            outputValidButton.value = false
        }
    }
}
