//
//  ClassAndStruct.swift
//  SecondApp
//
//  Created by 조우현 on 1/2/25.
//

import Foundation

// class는 모든 값이 초기화 즉, 초기값이 정해져 있어야 함
// 1. 가지고 있는 프로퍼티를 모두 초기화
// 2. 가지고 있는 프로퍼티를 옵셔널로 선언
// 3. init() 함수를 사요
class Monster {
    let clothes: String
    let speed: Int
    let power: Int
    let experience: Int
    
    init(clothes: String, speed: Int, power: Int, experience: Int) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.experience = experience
    }
}

class BossMonster: Monster {
    
}

class SuperMonster: BossMonster {
    
}

// init()이 없더라도 기본적으로 제공해줌 => 멤버와이즈 이니셜라이저
struct MonsterStruct {
    let clothes: String
    let speed: Int
    let power: Int
    let experience: Int
}
