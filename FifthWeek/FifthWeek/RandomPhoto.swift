//
//  RandomPhoto.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import Foundation

struct RandomPhoto: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: RandomPhotoURL
}

struct RandomPhotoURL: Decodable {
    let thumb: String
}
