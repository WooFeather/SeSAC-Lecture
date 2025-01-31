//
//  AnimationViewController.swift
//  FifthWeek
//
//  Created by 조우현 on 1/31/25.
//

import UIKit
import SnapKit
import Lottie

final class AnimationViewController: UIViewController {
    
    private let animationImageView = LottieAnimationView(name: "Test")
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none // 자동대문자 방지 옵션
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없으신가요? 회원가입"
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAnimations()
    }
    
    private func setupAnimations() {
        // 시작 alpha 0 -> 1 (혹은 isHidden true -> false)
        logoImageView.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)    // 1/10사이즈로 크기를 줄임
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        loginButton.alpha = 0
        signUpLabel.alpha = 0
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
            self.logoImageView.alpha = 1
            // scaleX을 1로 만들어주는 코드는 없지만, 아래의 transform으로 덮어씌워서 커지는 효과까지 적용됨
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 500) // 360이 한바퀴
        } completion: { _ in
            self.animationEmailTextField()
        }
    }
    
    private func animationEmailTextField() {
        UIView.animate(withDuration: 1, delay: 3, options: [.autoreverse]) {
            self.emailTextField.alpha = 1
        } completion: { _ in
            self.animationPasswordTextField()
        }
    }
    
    private func animationPasswordTextField() {
        UIView.animate(withDuration: 3) {
            self.passwordTextField.alpha = 1
        } completion: { _ in
            self.animationButton()
        }
    }
    
    private func animationButton() {
        UIView.animate(withDuration: 3) {
            self.loginButton.alpha = 1
        } completion: { _ in
            self.animationLabel()
        }
    }
    
    private func animationLabel() {
        UIView.animate(withDuration: 3) {
            self.signUpLabel.alpha = 1
        } completion: { _ in
            self.animationImageView.play { completed in
                print("로띠 애니메이션 끝~!")
            }
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [logoImageView, emailTextField, passwordTextField, loginButton, signUpLabel]
            .forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        view.addSubview(animationImageView)
        
        animationImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
