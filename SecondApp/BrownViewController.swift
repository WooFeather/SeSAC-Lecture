//
//  BrownViewController.swift
//  SecondApp
//
//  Created by 조우현 on 1/7/25.
//

import UIKit

class BrownViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
