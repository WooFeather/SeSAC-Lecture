//
//  PhotoManager.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import Foundation
import Alamofire
// 열거형 = @frozen, @unknown
// 열거형 케이스가 앞으로 추가될 일이 100% 발생하지 않으면 @frozen
// @frozen => 컴파일 최적화 => Frozen Enumeration

// 열거형의 연관값, Associated Value
// Moya, Alamofire URLRequestConvertible
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
            return URL(string: baseURL + "photos/random?count=10")!
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
    
    // 케이스별로 다를거니까 원래는 switch self 등으로 분기처리
    // key값도 파라미터로 빼서 호출할때 사용할 수 있음
    var parameter: Parameters {
        return [
            "page": "1",
            "color": "white",
            "order_by": "relevant"
        ]
    }
}

class PhotoManager {
    // (메타)타입 프로퍼티
    static let shared = PhotoManager()
    
    private init() { }
    
    func getRandomPhoto(
        api: UnsplashRequest,
        completionHandler: @escaping ([RandomPhoto]) -> Void,
        failHandler: @escaping () -> Void
    ) {
        // parameters: 무조건 쿼리스트링은 아님!! HTTP Body? query string?
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameter,
            encoding: URLEncoding(destination: .queryString),
            headers: api.header
        )
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [RandomPhoto].self) { response in
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
    
    func example<T: Decodable>(api: UnsplashRequest,
                               successHandler: @escaping (T) -> Void,
                               failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(_):
                    failHandler()
                }
            }
    }
    
    func example2<T: Decodable>(api: UnsplashRequest,
                                type: T.Type,
                                successHandler: @escaping (T) -> Void,
                                failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(_):
                    failHandler()
                }
            }
    }
    
    func example4(a: Int.Type) {
        print(a)
    }
}

//
//class JackVC: SearchViewController {
//    override func example() {
//        <#code#>
//    }
//}
