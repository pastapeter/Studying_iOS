//
//  EmployeeDAO.swift
//  FMDBPractice
//
//  Created by abc on 2021/08/31.
//

import Foundation

enum EmpStateType: Int {
  case ING = 0
  case STOP
  case OUT
  
  // 재직 상태를 문자열로 반환해주는 메소드
  func desc() -> String {
    switch self {
    case .ING:
      return "재직중"
    case .STOP:
      return "휴직"
    case .OUT:
      return "퇴사"
    }
  }
}

struct EmployeeVO {
  var empCd = 0
  var empName = ""
  var joinDate = ""
  var stateCd = EmpStateType.ING //디비에 저장될때 rawvalue써줘야한다는 말
  var departCd = 0
  var departTitle = ""
}

class EmployeeDAO {
  lazy var fmdb: FMDatabase! = {
    let fileMgr = FileManager.default
    
    let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
    let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
    
    if fileMgr.fileExists(atPath: dbPath) == false {
      let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    let db = FMDatabase(path: dbPath)
    return db
  }()
  
  init() {
    fmdb.open()
  }
  deinit {
    fmdb.close()
  }
  
  func find(departCd: Int = 0) -> [EmployeeVO] {
    var employeeList = [EmployeeVO]()
    
    do {
      let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)"
      let sql = """
        SELECT   emp_ cd, emp_name, join_date, state_cd, department.depart_title
        FROM     employee
        JOIN     department ON department.depart_cd = employee.depart_cd
        \(condition)
        ORDER BY employee.depart_cd ASC
        """
      let rs = try self.fmdb.executeQuery(sql, values: nil)
      while rs.next() {
        var record = EmployeeVO()
        record.empCd = Int(rs.int(forColumn: "emp_cd"))
        record.empName = rs.string(forColumn: "emp_name")!
        record.joinDate = rs.string(forColumn: "join_date")!
        let cd = Int(rs.int(forColumn: "department_title"))
        record.stateCd = EmpStateType(rawValue: cd)!
        
        employeeList.append(record)
      }
    } catch let error as NSError {
      print("\(error.localizedDescription)")
    }
    return employeeList
  }
  
  func get(empCd: Int) -> EmployeeVO? {
    let sql = """
      SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
      FROM   employee
      JOIN   department ON department.depart_cd = employee.depart_cd
      WHERE  emp_cd = ?
      """
    let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
    
    if let _rs = rs {
      _rs.next()
      var record = EmployeeVO()
      record.empCd = Int(_rs.int(forColumn: "emp_cd"))
      record.empName = _rs.string(forColumn: "emp_name")!
      record.joinDate = _rs.string(forColumn: "join_date")!
      let cd = Int(_rs.int(forColumn: "department_title"))
      record.stateCd = EmpStateType(rawValue: cd)!
      return record
    } else {
      return nil
    }
  }
  
  func create(param: EmployeeVO) -> Bool {
    do {
      let sql = """
        INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
        VALUES               (?, ?, ?, ?, ?)
        """
      //prepared statement를 위한 인자값
      var params = [Any]()
      params.append(param.empName)
      params.append(param.joinDate)
      params.append(param.stateCd.rawValue)
      params.append(param.departCd)
      
      try self.fmdb.executeUpdate(sql, values: params)
      return true
    } catch let error as NSError {
      return false
    }
  }
  
  func remove(empCd: Int) -> Bool {
    do {
      let sql = "DELETE FROM employee WHERE emp_cd = ?"
      try self.fmdb.executeQuery(sql, values: [empCd])
      return true
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return false
    }
  }
}
