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
        configuration.filter = .any(of: [.screenshots, .images])
        configuration.selectionLimit = 3
        configuration.mode = .default
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
}

extension BasicPHPickerViewController: PHPickerViewControllerDelegate {
    // 사진 선택을 마치고 추가버튼을 눌렀을 때 호출
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function)
        
        if let itemProvider = results.first?.itemProvider {
            // 객체를 로드할 수 있는지 확인
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                // 해당 객체를 로드할거야
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    
                    DispatchQueue.main.async {
                        self.photoImageView.image = image as? UIImage
                    }
                    
                }
            }
        }
        
        dismiss(animated: true)
    }
}
