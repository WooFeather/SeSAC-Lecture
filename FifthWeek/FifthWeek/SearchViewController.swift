//
//  SearchViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/22/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(textField)
        
        textField.delegate = self
        
//        textField.becomeFirstResponder()
        
        textField.backgroundColor = .yellow
        textField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }

}

extension SearchViewController: UITextFieldDelegate {
    // 리턴키를 탭했을 때
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("키보드 리턴키 클릭")
        textField.resignFirstResponder()
        return true
    }
}
