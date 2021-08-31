//
//  PickerController.swift
//  FMDBPractice
//
//  Created by abc on 2021/08/31.
//

import UIKit

class DepartPickerVC: UIViewController {
  
  let departDAO = DepartmentDAO()
  var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
  var pickerView: UIPickerView!
  
  // 현재 피커 뷰에 선택되어있는 부서의 코드를 가져온다.
  var selectedDepartCd: Int {
    let row = self.pickerView.selectedRow(inComponent: 0)
    return self.departList[row].departCd
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    self.departList = self.departDAO.find()
    self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    self.pickerView.dataSource = self
    self.pickerView.delegate = self
    self.view.addSubview(pickerView)
    
    //외부 뷰 컨트롤러를 참조할 때를 위한 사이즈 지정?
    let pWidth = self.pickerView.frame.width
    let pHeight = self.pickerView.frame.height
    self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
  }
}

extension DepartPickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.departList.count
  }
  
  // 피커뷰에 각 행에 표시될 뷰를 결정
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let titleView = view as? UILabel ?? {
      let titleView = UILabel()
      titleView.font = .systemFont(ofSize: 14)
      titleView.textAlignment = .center
      return titleView
    }()
    
    titleView.text = "\(self.departList[row].departTitle)(\(self.departList[row].departAddr))"
    return titleView
  }
}
