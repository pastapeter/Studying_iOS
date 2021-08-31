//
//  DepartmentListVC.swift
//  FMDBPractice
//
//  Created by abc on 2021/08/31.
//

import UIKit

class DepartmentListVC: UITableViewController {
  
  var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
  let departDAO = DepartmentDAO()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.tableView.tableFooterView = dummyView
    departList = departDAO.find()
    initUI()
  }
  
  func initUI() {
    let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    navTitle.numberOfLines = 2
    navTitle.textAlignment = .center
    navTitle.font = .systemFont(ofSize: 14)
    navTitle.text = "부서 목록 \n" + "총 \(self.departList.count) 개"
    
    self.navigationItem.titleView = navTitle
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    self.tableView.allowsSelectionDuringEditing = true
  }
  
  @IBAction func add(_ sender: Any) {
    let alert = UIAlertController(title: "신규부서등록", message: "신규부서등록해주세요", preferredStyle: .alert)
    alert.addTextField { (textfield) in
      textfield.placeholder = "부서명"
    }
    alert.addTextField { (textfield) in
      textfield.placeholder = "주소"
    }
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
      let title = alert.textFields?[0].text
      let addr = alert.textFields?[1].text
      
      if self.departDAO.create(title: title!, addr: addr!) {
        // 신규부서가 등록되면 DB에서 목록을 다시 읽어오고, 테이블을 갱신한다.
        self.departList = self.departDAO.find()
        self.tableView.reloadData()
        // 네비게이션 타이틀에도 변경된 부서 정보를 반영한다.
        guard let navTitle = self.navigationItem.titleView as? UILabel else {return}
        navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
      }
    }))
    self.present(alert, animated: false, completion: nil)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.departList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rowData = self.departList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL", for: indexPath)
    cell.textLabel?.text = rowData.departTitle
    cell.textLabel?.font = .systemFont(ofSize: 14)
    cell.detailTextLabel?.text = rowData.departAddr
    cell.detailTextLabel?.font = .systemFont(ofSize: 12)
    return cell
  }
  
  //MARK: - DELEGATE
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let departCd = self.departList[indexPath.row].departCd
    if departDAO.remove(departCd: departCd) {
      self.departList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

}
