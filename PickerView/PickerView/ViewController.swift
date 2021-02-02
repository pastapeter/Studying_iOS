//
//  ViewController.swift
//  PickerView
//
//  Created by abc on 2021/02/02.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLLUMN = 1
    let PICKER_VIEW_HEIGHT: CGFloat = 80
    var ImageArray = [UIImage?]()
    var imageFileName = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg", "6.jpeg", "7.jpeg", "8.jpeg", "9.jpeg", "10.jpeg"]
    
    // numberOfComponents은 the number of columns to display를 반환
    // 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메스드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLLUMN
    }
    
    // 컴포넌트의 열의 개수를 정수값으로 넘겨준다. 피커뷰의 해당 열에서 선택할 수 있는 행의 개수를 의미
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 컴포넌트의 각 열의 타이틀을 문자열 값으로 넘겨준다.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }

    @IBOutlet var pickerImaage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            ImageArray.append(image)
        }
        imageView.image = ImageArray[0]
        lblImageFileName.text = imageFileName[0]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text = imageFileName[row]
        imageView.image = ImageArray[row]
    }
    
    // 피커뷰에게 각 컴포넌트의 각 열의 뷰를 UIView 타입의 값으로 넘겨준다. 이미지뷰에 있는 이미지를 넘겨준다.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: ImageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
    
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
}


