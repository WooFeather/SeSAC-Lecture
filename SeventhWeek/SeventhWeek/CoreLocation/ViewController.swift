//
//  ViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

final class ViewController: UIViewController {
    
    // 1. 위치 매니저 생성: 위치에 관련된 대부분을 담당
    lazy var locationManager = CLLocationManager()
    
    let locationButton = UIButton()
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        // 최초 실행시 시스템 위치서비스 및 권한여부 확인
        // checkDeviceLocation() -> locationManager를 lazy로 선언한 경우 여기서 안해줘도 됨
        
        configureView()
        
        
//        NetworkManager.shared.getLotto { <#Lotto#> in
//            <#code#>
//        } failHandler: {
//            <#code#>
//        }

        
//        NetworkManager.shared.getLotto2 { lotto, error in
//             1. 하나라도 nil일 경우에 이 다음 코드가 실행이 안됨..?
//            guard let lotto = lotto,
//                  let error = error else { return }
//            
//             2. 이것도 마찬가지!!
//            guard let lotto = lotto else {
//                return
//            }
//            guard let error = error else {
//                return
//            }
//        }
        
//        NetworkManager.shared.getLotto3 { response in
//            switch response {
//            case .success(_):
//                // lotto값에 대한 대응
//            case .failure(_):
//                // error alert를 띄워주기
//            }
//        }
    }
    
    private func configureView() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        view.backgroundColor = .white
        locationButton.backgroundColor = .red
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func locationButtonClicked() {
        checkDeviceLocation()
    }

    // Alert: 시스템 위치서비스 활성화 여부 -> 권한 허용 Alert
    private func checkDeviceLocation() {
        DispatchQueue.global().async {
            // 시스템 위치서비스 활성화 여부 체크(타입메서드)
            if CLLocationManager.locationServicesEnabled() {
                self.checkCurrentLocation()
            } else {
                DispatchQueue.main.async {
                    // 실제 서비스에서는 Alert를 띄워서 사용자에게 알려야 함
                    print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없습니다.")
                }
            }
        }
    }
    
    // 현재 사용자의 위치 권한 상태 확인
    private func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구 띄울 수 있음")
            
            // Delegate의 didUpdateLocations 메서드는 위치가 변할 때마다 계속 호출됨 ⇒ 이 메서드의 호출 정도를 관리하는 코드라고 생각하면 됨
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 사용할 경우 위치정보 허용 알럿을 띄우는 코드
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("설정으로 이동하는 얼럿 띄우기")
        case .authorizedWhenInUse:
            print("정상 로직으로 실행하면 됨")
            // GPS기능을 써서 현재 위치를 가져와달라는 메서드!!!!
            locationManager.startUpdatingLocation()
        default:
            print("오류 발생")
        }
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region =  MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
    }
}

// 2. 위치 프로토콜 선언
extension ViewController: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        // print(locations)
        // print(locations.last?.coordinate) // 가장 최신 위치의 위경도 정보를 알 수 있음
        // 날씨 정보를 호출하는 API 호출 가능
        // 지도를 현재위치 중심으로 이동시키는 기능
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        } else {
            // 기본 위치 지정(시청 등)
        }
        
        // start를 했다면, 더이상 위치를 안받아와도 되는 시점에 stop을 외쳐줘야 함
        // ex. 날씨나 지도의 경우 어느 시점에만 위치를 받아오고 끝내면 되기 때문에 이렇게 바로 stop을 해줌
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 성공적으로 가지고 오지 못한 경우
    // ex. 사용자가 위치 허용 안함 / 자녀 보호 기능 등
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 사용자의 권한상태가 변경될 때 ex. 허용했었지만 시스템에서 안함으로 바꾸는 경우
    // locationManager 인스턴스가 생성이 될 때 ex. locationManager인스턴스를 lazy var로 선언하면 .notDetermine인 상태에도 해당 메서드가 실행됨
    // iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // NotDetermined 상태에서 권한 상태가 변경됐을 때 호출
        // ex. "앱을 사용하는 동안", "한번만", "허용안함" 등의 선택을 할 때
        // ex. 추후에 설정앱에서 권한 설정을 변경할 때
        print(#function)
        checkDeviceLocation()
    }
    
    // iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
