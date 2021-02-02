//
//  ViewController.swift
//  PickerView2
//
//  Created by abc on 2021/02/02.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let MAX_IMAGE_ARRAY = 10
    let PICKER_VIEW_COLUMN = 2
    let PICKER_VIEW_HEIGHT: CGFloat = 80
    var imageArray = [UIImage?]()
    var imageList = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg", "6.jpeg", "7.jpeg", "8.jpeg", "9.jpeg", "10.jpeg"]
    
    
    @IBOutlet var lblSelectedItem: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imagePickerVIew: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<MAX_IMAGE_ARRAY {
            let image = UIImage(named: imageList[i])
            imageArray.append(image)
        }
        imageView.image = imageArray[0]
        lblSelectedItem.text = imageList[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            imageView.image = imageArray[row]
        }
        else {
            lblSelectedItem.text = imageList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        return imageView
    }

//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageList[row]
//    }
}

