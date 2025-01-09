//
//  UIViewController+.swift
//  SecondApp
//
//  Created by 조우현 on 1/2/25.
//

import UIKit

// UIViewController를 따르고 있는 모든 애들에서 다 쓸 수 있음
// 나중에 뷰의 배경색을 바꿔야 할 때, 파일 하나하나 찾는게 아니라, 이 메서드만 수정하면 됨
extension UIViewController {
    
//    var nickname = "조우봉"
    
    func setViewBackground() {
        view.backgroundColor = .lightGray
    }
    
    func setLabel(_ label: UILabel, text: String) {
        label.text = text
    }
}
