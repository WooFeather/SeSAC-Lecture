//
//  HorizontalScrollViewController.swift
//  FourthWeek
//
//  Created by 조우현 on 1/17/25.
//

import UIKit
import SnapKit

class HorizontalScrollViewController: UIViewController {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.backgroundColor = .yellow
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50) // 가로스크롤 할거라서 높이 고정
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)  // horizontalEdge로 해도 되지만, 이렇게 해도 됨
            make.height.equalTo(50)
        }
        
        // stackView 안의 각 label의 레이아웃을 결정해줄 필요는 없음
        // 스크롤뷰의 높이는 정해져있고, 너비는 자동으로 결정되기 때문에
        // stackView 안의 여백만 결정해줌
        stackView.spacing = 10
        
        configureLabel()
    }
    
    func configureLabel() {
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = "slafdsafdsafdsafdafdsafdsafdsafdfsafdsa"
        stackView.addArrangedSubview(label) // stackView에 넣을땐 addSubview가 아니라 addArrangedSubview사용
        
        let label2 = UILabel()
        label2.backgroundColor = .brown
        label2.text = "slafds"
        stackView.addArrangedSubview(label2)
        
        let label3 = UILabel()
        label3.text = "33456"
        label3.backgroundColor = .orange
        label3.textColor = .white
        stackView.addArrangedSubview(label3)
        
        let label4 = UILabel()
        label4.text = "34354aasdfsadssafdsafdsa53456"
        label4.backgroundColor = .brown
        label4.textColor = .white
        stackView.addArrangedSubview(label4)
        
        let label5 = UILabel()
        label5.text = "3435453456"
        label5.backgroundColor = .orange
        label5.textColor = .white
        stackView.addArrangedSubview(label5)
    }

}
