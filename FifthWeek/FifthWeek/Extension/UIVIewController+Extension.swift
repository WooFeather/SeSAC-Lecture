//
//  UIVIewController+Extension.swift
//  FifthWeek
//
//  Created by 조우현 on 1/22/25.
//

import UIKit

// Generic: 타입에 유연하게 대응
// T: Type Parameter - 플레이스 홀더(무슨 타입인진 모르지만 동일한 타입이 들어올거라는 걸 알려줌)
// Type Constraints (클래스 제약/프로토콜 제약)
// 함수 구성에선 타입을 알 수 없고, 함수를 호출할 때 타입이 결정됨
extension UIViewController {
    // 네모박스를 만들어주자
    
    func example<T>(CompletionHandler: @escaping (T) -> Void) -> String {
        return "안녕하세요"
    }
    
    func plus<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a + b
    }
    
    // 모든 뷰에 공통된 테두리를 설정하는 코드
    func configureBorder<T: UIView>(view: T) {
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .clear
    }
}
