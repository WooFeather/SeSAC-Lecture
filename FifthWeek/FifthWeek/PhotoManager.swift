//
//  PhotoManager.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import Foundation
import Alamofire

// 열거형의 연관값, Associated Value
enum UnsplashRequest {
    case randomPhoto
    case topic(id: String)
    case photo(query: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .randomPhoto:
            return URL(string: baseURL + "photos/random")!
        case .topic(let id):
            return URL(string: baseURL + "topics/\(id)")!
        case .photo(let query):
            return URL(string: baseURL + "photos/\(query)")!
        }
    }
    
    // 모든 케이스들에 대응
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKey.unsplashAccessKey)"]
    }
    
    // 만약 케이스별로 method가 다르다면 switch self로 분기처리
    var method: HTTPMethod {
        return .get
    }
}

class PhotoManager {
    static let shared = PhotoManager()
    
    private init() { }
    
    func getRandomPhoto(
        api: UnsplashRequest,
        completionHandler: @escaping (RandomPhoto) -> Void,
        failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func callRequest(api: UnsplashRequest) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getATopic(api: UnsplashRequest) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Topic.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
