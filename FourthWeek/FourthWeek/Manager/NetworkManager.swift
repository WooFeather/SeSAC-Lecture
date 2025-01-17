//
//  NetworkManager.swift
//  FourthWeek
//
//  Created by 조우현 on 1/16/25.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
//    func callKakaoBookTest(query: String, page: Int) -> Book {
//        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
//        let header: HTTPHeaders = [
//            "Authorization": APIKey.kakao
//        ]
//        
//        print(#function, url)
//        
//        AF.request(url, method: .get, headers: header)
//            .validate(statusCode: 200..<500)
//            .responseDecodable(of: Book.self) { response in
//                print(response.response?.statusCode ?? 00)
//                
//            switch response.result {
//            case .success(let value):
//                print("✅SUCCESS")
//                return value
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//        return testtest // => AF는 아직 끝나지 않았는데 이 리턴값을 넘겨주면 이상한 값을 넘겨주는것임
//    }
    
    func callKakaoBookAPI(query: String, page: Int, completionHandler: @escaping (Book) -> Void ) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": APIKey.kakao
        ]
        
        print(#function, url)
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Book.self) { response in
                print(response.response?.statusCode ?? 00)
                
            switch response.result {
            case .success(let value):
                print("✅SUCCESS")
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func randomUser(completionHandler: @escaping (String) -> Void) {
        let url = "https://randomuser.me/api/?results=10"
        
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS", value.results[0].name.last)
                
                let result = value.results[0].name.last
                completionHandler(result)
                
            case .failure(let error):
                print("ERROR")
                print(error)
            }
        }
    }
}
