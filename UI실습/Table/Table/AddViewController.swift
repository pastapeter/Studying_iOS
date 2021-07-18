//
//  AddViewController.swift
//  Table
//
//  Created by abc on 2021/02/06.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let itemsImage = ["cart.png", "clock.png", "pencil.png"]
    let PICKER_VIEW_HEIGHT: CGFloat = 80
    let PICKER_VIEW_COLUMN = 1
    var ImageArray = [UIImage?]()
    var selectedImage: String?
    
    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pickerImage: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in  0 ..< itemsImage.count{
            let image = UIImage(named: itemsImage[i])
            ImageArray.append(image)
        }
        imageView.image = ImageArray[0]
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(selectedImage!)
        tfAddItem.text = ""
        _ = navigationController?.popViewController(animated: true) // 루트 뷰 컨트롤러, 즉 테이블 뷰로 돌아간다.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //컴포넌트 수
        return PICKER_VIEW_COLUMN
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsImage.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            imageView.image = ImageArray[row]
            selectedImage = itemsImage[row]
    }
        
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return itemsImage[row]
//    }
//
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: ImageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        return imageView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
