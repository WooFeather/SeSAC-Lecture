//
//  GroupViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/21/25.
//

import UIKit
import Kingfisher

class GroupViewController: UIViewController {
    
    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        return view
    }()
    
    let checkButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        return btn
    }()
    
    var firstValue = ""
    var secondValue = ""
    var thirdValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(firstImageView)
        view.addSubview(checkButton)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(firstImageView.snp.bottom).offset(20)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(secondImageView.snp.bottom).offset(20)
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc func checkButtonTapped() {
        print(#function)
        
        let group = DispatchGroup()
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            self.firstValue = photo.urls.thumb
            group.leave()
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            self.secondValue = photo.urls.thumb
            group.leave()
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            self.thirdValue = photo.urls.thumb
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("불러오기 끝~!", Thread.isMainThread)
            self.firstImageView.kf.setImage(with: URL(string: self.firstValue))
            self.secondImageView.kf.setImage(with: URL(string: self.secondValue))
            self.thirdImageView.kf.setImage(with: URL(string: self.thirdValue))
        }
    }
}
