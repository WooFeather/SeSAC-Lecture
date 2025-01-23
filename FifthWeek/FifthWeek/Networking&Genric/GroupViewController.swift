//
//  GroupViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import UIKit
import Kingfisher

//class User {
//    static let name = "하이"
//}

class GroupViewController: UIViewController {
    
    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        return view
    }()
    
    let checkButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        return btn
    }()
    
    var firstValue = ""
    var secondValue = ""
    var thirdValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoManager.shared.example4(a: Int.self)
        
//        User.self.name
        
//        var age: Int = 3
//        var name: String = "안녕"
//        var test: String.Type = String.self
//        
        // 1. 타입어노테이션으로 명시
//        PhotoManager.shared.example(api: .randomPhoto) { (value: RandomPhoto) in
//            print("랜덤포토 통신 성공")
//            dump(value)
//        } failHandler: {
//            print("통신 실패한 경우 얼럿")
//        }
//
//        PhotoManager.shared.example(api: .topic(id: "wallpapers")) { (value: Topic) in
//            print("토픽 통신 성공")
//            dump(value)
//        } failHandler: {
//            print("통신 실패한 경우 얼럿")
//        }
//        
//        // 2. 매개변수에 T 타입 명시
//        PhotoManager.shared.example2(api: .randomPhoto, type: RandomPhoto.self) { value in
//            print("랜덤포토 통신 성공")
//            dump(value)
//        } failHandler: {
//            print("통신 실패한 경우 얼럿")
//        }
//
//        
////        example(a: 7) { value in
////            <#code#>
////        }
//        
//        Dummy(mainContents: "65", subContents: "67", others: 122)
//        Dummy(mainContents: true, subContents: false, others: 8.9)
//        
//        configureBorder(view: checkButton)
//        
//        let a = plus(a: 3, b: 2)
//        print(a)
//        
//        let b = plus(a: 4.6, b: 1.2)
//        
////        let c = plus(a: "안녕", b: "하세요")
//        
//        
//        // switch에서 default가 필요하거나 필요하지 않는 이유
////        var number = Int.random(in: 1...3)
////        
////        switch number {
////        case 1:
////            print("1")
////        case 2:
////            print("2")
////        case 3:
////            print("3")
////        default: // number의 값이 변경될 수 있기 때문에
////            <#code#>
////        }
//        
//        // @unknown: 라이브러리나 프레임워크에서 만들어진 열거형의 모든 멤버(case)를 처리했음에도 불구하고 @unknown default를 써야 추후에 case가 추가됐을때 대응해야 함
////        let value = NSTextAlignment.center
////        
////        switch value {
////            
////        case .left:
////            <#code#>
////        case .center:
////            <#code#>
////        case .right:
////            <#code#>
////        case .justified:
////            <#code#>
////        case .natural:
////            <#code#>
////        @unknown default:
////            <#code#>
////        }
//        
//        PhotoManager.shared.callRequest(api: .randomPhoto)
//        PhotoManager.shared.callRequest(api: .photo(query: "yd4daZHEtcA"))
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(firstImageView)
        view.addSubview(checkButton)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(firstImageView.snp.bottom).offset(20)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(secondImageView.snp.bottom).offset(20)
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        print(#function)
        
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
        
//        let group = DispatchGroup()
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.firstValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.secondValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.thirdValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
//        
//        group.notify(queue: .main) {
//            print("불러오기 끝~!", Thread.isMainThread)
//            self.firstImageView.kf.setImage(with: URL(string: self.firstValue))
//            self.secondImageView.kf.setImage(with: URL(string: self.secondValue))
//            self.thirdImageView.kf.setImage(with: URL(string: self.thirdValue))
//        }
    }
}
