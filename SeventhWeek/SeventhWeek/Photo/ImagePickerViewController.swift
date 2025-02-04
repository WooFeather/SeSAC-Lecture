//
//  ImagePickerViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/4/25.
//

import UIKit
import SnapKit

class ImagePickerViewController: UIViewController {

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
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        // imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Picker에서 사진을 골랐을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        let image = info[UIImagePickerController.InfoKey.editedImage]
        
        if let result = image as? UIImage {
            photoImageView.image = result
        } else {
            // 토스트메세지, 알럿 띄우기 등
        }
        
        dismiss(animated: true)
    }
    
    // 취소버튼을 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
