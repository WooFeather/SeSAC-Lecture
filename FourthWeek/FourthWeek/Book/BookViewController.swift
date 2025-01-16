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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.randomUser { name in
            self.navigationItem.title = name
        }
    }
}
