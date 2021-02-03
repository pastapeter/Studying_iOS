//
//  ViewController.swift
//  Map
//
//  Created by abc on 2021/02/03.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로
        locationManager.requestWhenInUseAuthorization() //위치데이터 추적하기 위해서 사용자에게 승인을 요구한다.
        locationManager.startUpdatingLocation() //위치 업데이트 시작
        myMap.showsUserLocation = true // 위치보기값을 true로 설정
        
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    //특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서비 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트되면 가장 마지막 위치값을 찾아낸다.
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) //delta 값은 값이작을수록 확대되는 효과 -> 1의 값보다 지도를 100배로 확대해서 보여줄 것
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first //placemarks 값의 첫부분만 pm 상수로 대입
            let country = pm!.country // pm 상수에서 나라 값을 country 상수값에 대입
            var address: String = country! // 문자열 address에 country 상수의 값을 대입합니다.
            if pm!.locality != nil { //pm 상수에서 지역값이 존재하면 address 문자열에 추가합니다.
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil { // pm 상수에서 도로 값이 존재하면 address 문자열에 추가합니다.
                address += " "
                address += pm!.thoroughfare!
            }
            self.lblLocationInfo1.text = "현재위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation() // 마지막으로 위치가 없데이트되는 것을 멈추게 한다.
    }
    
    //세그먼트 컨트롤 선택하엿을때 호출
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            // "현재 위치" 선택 - 현재 위치 표시
            self.lblLocationInfo1.text = " "
            self.lblLocationInfo2.text = " "
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            // "폴리텍 대학" 선택 - 핀을 설치하고 위치 정보를 표시
            setAnnotation(latitudeValue: 37.50517857749466 , longitudeValue: 126.95712823935891, delta: 0.1, title: "서울중앙대학교", subtitle: "서울특별시 동작구 흑석동 흑석로 84")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "중앙대학교 서울캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            // "이지스퍼블리싱" 선택 - 핀을 설치하고 위치 정보 표시
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
    
}

