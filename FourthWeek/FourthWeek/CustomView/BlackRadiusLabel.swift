//
//  BlackRadiusLabel.swift
//  FourthWeek
//
//  Created by 조우현 on 1/15/25.
//

import UIKit

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SubLabel: BaseLabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

class PointButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol SeSAC {
    // 이 프로토콜을 채택하면 반드시 init() 즉, 초기화해야된다는 요구사항
    init()
}

class Mentor: SeSAC {
    required init() {
        // Mentor의 인스턴스를 생성할 때 프린트됨
        print("Mentor Init")
    }
}

class Jack: Mentor {
    // override가 붙은 이유 => 부모에도 초기화 구문이 있어야 해서
    required init() {
        // 부모에 있는 초기화구문도 실행할래~ 하면 super.init()
        // super.init()을 하지 않으면 "Mentor Init" 이게 프린트가 안됨
        super.init()
        print("Jack Init")
    }
}

class BlackRadiusLabel: UILabel {
    
    init(color: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 15)
        textColor = .white
        backgroundColor = color
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
    }
    
    // 코드베이스로 코드를 구성할 때 호출되는 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    // 스토리보드로 구성할 때 호출되는 초기화 구문
    // 프로토콜에 구현된 init => required initializer
    // 실패가능한 이니셜라이저(Failable Initializer)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
