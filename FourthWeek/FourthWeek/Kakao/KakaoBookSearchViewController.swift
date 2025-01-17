//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
/*
 페이지네이션
 1. 스크롤이 끝날 쯤 다음 페이지를 요청 (page += 1 후 callRequest)
 2. 이전 내용도 확인해야 해서 list.append로 수정
 
 추가해결할것
 - 다른 검색어를 입력한 경우, 배열 초기화 + 1페이지로 다시 초기화 + 상단 스크롤
 - 마지막 페이지인 경우 더이상 호출하지 않기
 */

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list: [BookDetail] = []
    
    var page = 1
    var isEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSearchBar()
        configureTableView()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)
    }
    /*
     1. 검색어
     2. 이미지
     3. 이미 검색어에 대한 결과가 나와있는 상태에서 동일한 요청을 하면?
     */
    func callRequest(query: String) {
//        let result = NetworkManager.shared.callKakaoBookTest(query: query, page: page)
//        list = result.documents
        
        NetworkManager.shared.callKakaoBookAPI(query: query, page: page) { value in
            self.isEnd = value.meta.is_end
            
            if self.page == 1 {
                self.list = value.documents
            } else {
                self.list.append(contentsOf: value.documents)
            }
            
            self.tableView.reloadData()
            
            if self.page == 1 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
}

extension KakaoBookSearchViewController: UISearchBarDelegate {
    // 검색 버튼 클릭시 무조건 통신되지 않고,
    // 빈칸, 최소 1자 이상, 같은 글자에 대한 처리 필요!
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        page = 1
        if let searchText = searchBar.text {
            callRequest(query: searchText)
        }
    }
}

extension KakaoBookSearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print(#function, indexPaths)
        
        // size 20개 => 사용자가 마지막에 조회할 수 있는 셀의 indexPath는 [0,19]인것
        for item in indexPaths {
            if list.count - 2 == item.row && isEnd == false {
                page += 1
                callRequest(query: searchBar.text!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        // 사용자가 페이지를 빠르게 스크롤하면, 중간에 지나가는 셀이 생기고, 그 셀에 대해서는 데이터 처리가 필요없을수도 있어, 이미지 다운로드 같은 기능을 취소하는 작업을 구현!
    }
}

extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function, indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.subTitleLabel.text = data.price.formatted()
        cell.overviewLabel.text = data.contents
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print(#function, indexPath)
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(#function, scrollView.contentSize.height, scrollView.contentOffset.y)
//    }
}

