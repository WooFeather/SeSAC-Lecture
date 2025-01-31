//
//  UIButton+Extension.swift
//  FifthWeek
//
//  Created by 조우현 on 1/31/25.
//

import UIKit

extension UIButton.Configuration {
    static func myStyle(title: String, subTitle: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.subtitle = subTitle
        config.imagePlacement = .trailing
        config.titlePadding = 4
        config.imagePadding = 4
        config.image = UIImage(systemName: "star")
        config.cornerStyle = .capsule
        config.baseForegroundColor = .green
        config.baseBackgroundColor = .brown
        
        return config
    }
}
