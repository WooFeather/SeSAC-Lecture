//
//  ModalViewController.swift
//  SecondApp
//
//  Created by 조우현 on 12/31/24.
//

import UIKit

class ModalViewController: UIViewController {

    let colorList: [UIColor] = [.red, .blue, .green, .yellow, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 어떤 VC인지 구분하기 위해 self 붙여줌
        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = colorList.randomElement()!
        super.viewDidAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
}
