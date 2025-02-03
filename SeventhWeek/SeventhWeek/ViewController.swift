//
//  ViewController.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/3/25.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // 1. 위치 매니저 생성: 위치에 관련된 대부분을 담당
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        checkDeviceLocation()
    }

    // Alert: 시스템 위치서비스 활성화 여부 -> 권한 허용 Alert
    func checkDeviceLocation() {
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
    func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구 띄울 수 있음")
            
            // Delegate의 해당 코드는 위치가 변할 때마다 계속 호출됨 ⇒ 이 메서드의 호출 정도를 관리하는 코드라고 생각하면 됨
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
}

// 2. 위치 프로토콜 선언
extension ViewController: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        print(locations.last?.coordinate) // 가장 최신 위치의 위경도 정보를 알 수 있음
        // 날씨 정보를 호출하는 API 호출 가능
        // 지도를 현재위치 중심으로 이동시키는 기능
        
        // start를 했다면, 더이상 위치를 안받아와도 되는 시점에 stop을 외쳐줘야 함
        // ex. 날씨나 지도의 경우 어느 시점에만 위치를 받아오고 끝내면 되기 때문에 이렇게 바로 stop을 해줌
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 성공적으로 가지고 오지 못한 경우
    // ex. 사용자가 위치 허용 안함 / 자녀 보호 기능 등
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 사용자의 권한상태가 변경될 때
    // ex. 허용했었지만 시스템에서 안함으로 바꾸는 경우
    // iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // NotDetermined 상태에서 "한 번 허용"을 눌렀을 경우 해당 메서드 호출
        print(#function)
        checkDeviceLocation() // 질문...! 잘 이해 못함!!!!
    }
    
    // iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
