//
//  ViewController.swift
//  Map2
//
//  Created by abc on 2021/02/04.
//

// 지도 띠우기, 위치 업데이트
// 현재위치 경도 위도
// 특정 위도, 경도에 핀 설치하고 핀에 타이틀과 서븟타이틀 문자표시
// 위치정보에서 국가, 지역도, 도록를 추출하고 레이블
// 세그먼트 컨트롤 선택할때 호출


import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblCurrentInfo1: UILabel!
    @IBOutlet var lblCurrentInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 현재 표시할 것이 없기때문에
        lblCurrentInfo1.text = ""
        lblCurrentInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            self.lblCurrentInfo1.text = "현재위치:"
            self.lblCurrentInfo2.text = address
        })
        locationManager.stopUpdatingLocation()
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.lblCurrentInfo1.text = ""
            self.lblCurrentInfo2.text = ""
            locationManager.startUpdatingLocation()
        }
        else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitudeValue: 37.50511254944148, longitudeValue: 126.95709985671664, delta: 0.1, title: "중앙대학교 서울캠퍼스", subtitle: "서울특별시 동작구 흑석동 흑석로 84")
            self.lblCurrentInfo1.text = "중앙대학교 서울캠퍼스"
            self.lblCurrentInfo2.text = "서울특별시 동작구 흑석동 흑석로 84"
        }
        else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitudeValue: 37.29404694285166, longitudeValue: 127.20252348247165, delta: 0.1, title: "애버랜드", subtitle: "경기도 용인시 처인구 포곡읍 에버랜드로 199")
            self.lblCurrentInfo1.text = "애버랜드"
            self.lblCurrentInfo2.text = "경기도 용인시 처인구 포곡읍 에버랜드로 199"
        }
        else if sender.selectedSegmentIndex == 3{
            setAnnotation(latitudeValue: 37.579272634252014, longitudeValue: 126.91299929782329, delta: 0.1, title: "우리집", subtitle: "서울특별시 서대문구 거북골로14길 94")
            self.lblCurrentInfo1.text = "우리집"
            self.lblCurrentInfo2.text = "서울특별시 서대문구 거북골로14길 94"
        }

    }
    
}

