//
//  BasicPHPickerViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/4/25.
//

import UIKit
import PhotosUI
import SnapKit

class BasicPHPickerViewController: UIViewController {

    private let pickerButton = UIButton()
    private let photoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(pickerButton)
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        pickerButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoImageView.backgroundColor = .lightGray
        pickerButton.backgroundColor = .blue
        
        pickerButton.addTarget(self, action: #selector(pickerButtonClicked), for: .touchUpInside)
    }

    @objc
    private func pickerButtonClicked() {
        print(#function)
        
        var configuration = PHPickerConfiguration()
        
        let picker = PHPickerViewController(configuration: configuration)
        
        present(picker, animated: true)
    }
}
