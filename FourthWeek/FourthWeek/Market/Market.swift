//
//  Market.swift
//  FourthWeek
//
//  Created by 조우현 on 1/15/25.
//

import Foundation

/*
 서버에서 키를 바꾸면 앱이 터진다. => DecodingStrategy
 - 옵셔널을 통한 해결
 - CodingKey
 */
struct Market: Decodable {
    let market: String
    let name: String?
    let korean: String
    let english: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case name
        case korean = "korean_name"
        case english = "english_name"
    }
}
