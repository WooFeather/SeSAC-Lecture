//
//  UIColor+Extension.swift
//  SecondApp
//
//  Created by 조우현 on 1/6/25.
//

import UIKit

extension UIColor {
    // 저장 프로퍼티, 인스턴스 프로퍼티 ❌
//    var brandColor = UIColor.red
    
    // 저장 프로퍼티, 타입 프로퍼티 ✅
    static var backgroundColor = UIColor.red
    
    // 연산 프로퍼티, 인스턴스 프로퍼티 ✅
    var denColor: UIColor {
        return .red
    }
}
