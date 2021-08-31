//
//  EmployeeListVC.swift
//  FMDBPractice
//
//  Created by abc on 2021/08/31.
//

import UIKit

class EmployeeListVC: UITableViewController {
  
  var empList: [EmployeeVO]!
  var empDAO = EmployeeDAO()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.tableView.tableFooterView = dummyView
    empList = empDAO.find()
    initUI()
  }
  
  func initUI(){
    let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    navTitle.numberOfLines = 2
    navTitle.textAlignment = .center
    navTitle.font = .systemFont(ofSize: 14)
    navTitle.text = "사원 목록 \n" + " 총 \(empList.count) 명"
    self.navigationItem.titleView = navTitle
  }
  
  @IBAction func add(_ sender: Any) {
    let alert = UIAlertController(title: "사원 등록", message: "등록할 사원 정보를 입력해주세요", preferredStyle: .alert)
    alert.addTextField { (textfield) in
      textfield.placeholder = "사원명"
    }
    let pickerVC = DepartPickerVC()
    alert.setValue(pickerVC, forKey: "contentViewController")
    
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "확인", style: .default){ (_) in
      var param = EmployeeVO()
      param.departCd = pickerVC.selectedDepartCd
      param.empName = (alert.textFields?[0].text)!
      
      //가입일을 오늘로
      let df = DateFormatter()
      df.dateFormat = "yyyy-mm-dd"
      param.joinDate = df.string(from: Date())
      
      //재직중으로
      param.stateCd = EmpStateType.ING
      
      //DB처리
      if self.empDAO.create(param: param) {
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
        
        if let navTitle = self.navigationItem.titleView as? UILabel {
          navTitle.text = "사원 목록 \n" + " 총 \(self.empList.count) 명"
        }
      }
    })
    self.present(alert, animated: false, completion: nil)
  }
  
  @IBAction func editing(_ sender: Any) {
    if self.isEditing == false { // 현재 편집모드가 아님
      self.setEditing(true, animated: true)
      (sender as? UIBarButtonItem)?.title = "Done"
    } else {
      self.setEditing(false, animated: true)
      (sender as? UIBarButtonItem)?.title = "Edit"
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return empList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rowData = empList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL", for: indexPath)
    cell.textLabel?.text = rowData.empName + "\(rowData.stateCd.desc())"
    cell.textLabel?.font = .systemFont(ofSize: 14)
    cell.detailTextLabel?.text = rowData.departTitle
    cell.detailTextLabel?.font = .systemFont(ofSize: 12)
    return cell
  }
  
  //MARK: - DELEGATE

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // 삭제할 행의 empCd를 구한다.ㅏ
    let empCd = empList[indexPath.row].empCd
    // db에서, 데이터소스에서, 그리고 테이블 뷰에서 모두 삭제
    if empDAO.remove(empCd: empCd) {
      empList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}

