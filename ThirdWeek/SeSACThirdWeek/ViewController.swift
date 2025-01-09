//
//  ViewController.swift
//  SeSACThirdWeek
//
//  Created by 조우현 on 1/8/25.
//

import UIKit
import MapKit

struct User {
    var name: String
}

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var secondTextField: UITextField!
    
    let pickerView = UIPickerView()
    
    let color: [UIColor] = [.init(.blue)]
    
    // User가 계속 반복됨
    let user: [User] = [
        User(name: "a"),
        User(name: "b")
    ]
    
    // .init으로 생성하는게, 인스턴스 생성 시간이 가장 오래걸림
    let person: [User] = [
        .init(name: "a"),
        .init(name: "b")
    ]
    
    let list = ["가", "나", "다"]
    let array = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTextField.tintColor = .clear
        secondTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        userTextField.delegate = self
        
        mapView.delegate = self
        
        configureMapView()
    }
}

// MARK: - 뷰객체 설정
extension ViewController {
    func configureMapView() {
        let center = CLLocationCoordinate2D(latitude: 37.65370, longitude: 127.04740)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "창동티비"
        mapView.addAnnotation(annotation)
    }
}

// MARK: - PickerView 설정
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? list.count : array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? list[row] : array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component, row)
        
        if component == 0 {
            userTextField.text = list[row]
        } else {
            secondTextField.text = array[row]
        }
    }
}

// MARK: - TextField 설정
extension ViewController: UITextFieldDelegate {
    // 키보드에서 엔터키를 탭했을 때
    // didEndOnExit과 다른점 => 얘는 키보드를 내리는거까지
    // textFieldShouldReturn => 얘는 엔터키를 눌렀을 때
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userTextField {
            view.endEditing(true)
        }
        
        return true
    }
}
