//
//  BookViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/13/25.
//

import UIKit

class BookViewController: UIViewController {
    
    // 원래의 view와 구분짓기 위한 네이밍
    var mainView = BookView()
    
    // UIView를 내가 만든 커스텀 View로 대체하도록 만들어줌
    // 이친구는 super를 쓰지 않음
    // 그 이유는, super를 통해 view의 설정을 다시 가져오면 내가 만든 커스텀View가 안보일수도 있기 때문
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이제 collectionView가 mainView에 있기 떄문에 이렇게 수정
        
    }
}
