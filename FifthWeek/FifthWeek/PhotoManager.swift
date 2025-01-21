//
//  PhotoManager.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import Foundation
import Alamofire

class PhotoManager {
    static let shared = PhotoManager()
    
    private init() { }
    
    func getRandomPhoto(completionHandler: @escaping (RandomPhoto) -> Void) {
        let url = "https://api.unsplash.com/photos/random"
        
        let header: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.unsplashAccessKey)"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
