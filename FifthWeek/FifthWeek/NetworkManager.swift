//
//  NetworkManager.swift
//  FifthWeek
//
//  Created by 조우현 on 1/20/25.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    static let url = URL(string: "https://picsum.photos/200/200")!
    
    private init() { }
    
    func fetchImage(completionHandler: @escaping (UIImage) -> Void) {
        print(#function)

        // 이 블럭 안에 들어가는 친구는 메인이 아닌 다른친구가 일함
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: NetworkManager.url) {
                if let image = UIImage(data: data) {
                    // UI를 그려주는 일은 main한테 다시 넘겨주기
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        }
    }
}
