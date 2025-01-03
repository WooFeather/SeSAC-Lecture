//
//  ViewController.swift
//  SecondApp
//
//  Created by 조우현 on 12/30/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var wordTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://search.pstatic.net/common?type=b&size=336&quality=100&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2FprofileImg%2Fd7f327eb-f9db-4e9e-883c-3ca6f88ee8c1.jpg") {
            posterImageView.kf.setImage(with: url)
        } else {
            print("옵셔널 언래핑 오류티비!!!!")
            posterImageView.image = UIImage(systemName: "xmark")
        }
        
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        print(resultLabel.isUserInteractionEnabled)
        resultLabel.isUserInteractionEnabled = true
        
        //        checkButton.isEnabled = false
        checkButton.isUserInteractionEnabled = false
    }
    
    // Did End On Exit
    // UITextField text, UILabel text: String?
    @IBAction func textFieldReturnKeyTapped(_ sender: UITextField) {
        let text = wordTextField.text!.lowercased()
        print(text)
        
        // 글자수, 공백 모두 대응해야 함
        if text.count == 0 {
            resultLabel.text = "검색어를 작성해주세요."
        } else if text == "jmt" {
            resultLabel.text = "완전맛있음"
        } else {
            resultLabel.text = "\(text)라고 입력했어요."
        }
    }
    
    @IBAction func labelTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    func aboutOptional() {
        // :String? => 옵셔널 스트링 타입
        var nickname: String? = "조우봉"
        var age: Int? = 28
        
        nickname = nil
        
        // 1. 조건문을 통해 옵셔널 언래핑
        if nickname != nil {
            print("\(nickname!)으로 설정합니다.")
        } else {
            print("닉네임에 문제가 있어요!")
        }
        
        // 2. 옵셔널 바인딩: if let / guard let
        if let nickname {
            print("\(nickname)으로 설정합니다.")
        } else {
            print("닉네임에 문제가 있어요!")
        }
        
        if let age {
            print("제 나이는 \(age)살입니다")
        } else {
            print("제 나이를 몰라요 ㅜ  ㅜ")
        }
        
        print(age)  // Int?
        
        guard let age else {
            print("age 옵셔널 해제 실패")
            return
        }
        
        print(age)  // Int
        
        // 3. ??
        print(nickname ?? "손님")
        
        // 4. 옵셔널 체이닝
        print(wordTextField.text?.count)
        
        if let text = wordTextField.text {
            print(text.count)
        }
    }
}

