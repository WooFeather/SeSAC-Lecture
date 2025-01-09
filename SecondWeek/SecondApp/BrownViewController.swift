//
//  BrownViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/7/25.
//

import UIKit

class BrownViewController: UIViewController {
    @IBOutlet var testLabel: UILabel!
    
    // 1. Pass Data - 데이터를 받을 공간(프로퍼티 생성)
    // 화면전환시 Label(Outlet)에 바로 접근을 못하니 대체공간 만들어준 것
    // 스토리보드에서 초기화하는건 굉장히 복잡함 => 옵셔널로 처리하면서 해결
    var contents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. Pass Data - 전달받은 값을 화면에 표현
        testLabel.text = contents

        navigationItem.title = "안녕"
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissBruttonTapped(_ sender: UIButton) {
        print(#function)
        dismiss(animated: true)
    }
}
