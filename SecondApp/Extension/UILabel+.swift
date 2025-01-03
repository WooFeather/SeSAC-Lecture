//
//  UILabel+.swift
//  SecondApp
//
//  Created by 조우현 on 1/2/25.
//

import UIKit

extension UILabel {
    func setPrimaryLabel(_ text: String) {
        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .blue
        self.textAlignment = .center
        self.text = text
    }
}
