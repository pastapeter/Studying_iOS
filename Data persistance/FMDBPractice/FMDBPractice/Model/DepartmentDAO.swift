//
//  DepartmentDAO.swift
//  FMDBPractice
//
//  Created by abc on 2021/08/31.
//

import Foundation


enum Department: String {
  case department
  case departCd = "depart_cd"
  case departTitle = "depart_title"
  case departAddr = "depart_addr"
}

class DepartmentDAO {
  typealias DepartRecord = (Int, String, String)
  
  lazy var fmdb: FMDatabase! = {
    //1. filemanager 객체 생성
    let fileMgr = FileManager.default
    
    //2. 샌드박스 낸 문서 디렉터리에서 데이터베이스 파일 경로 확인
    let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
    let dbPath = docPath.appendingPathComponent("hr.sqlite").path
    
    //3. 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite을 가져와 복사
    if fileMgr.fileExists(atPath: dbPath) == false {
      let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    
    //4 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
    let db = FMDatabase(path: dbPath)
    return db
  }()
  
  init() {
    self.fmdb.open()
  }
  
  deinit {
    self.fmdb.close()
  }
  
  func find() -> [DepartRecord] {
    var departList = [DepartRecord]()
    
    do {
      let sql = """
        SELECT depart_cd, depart_title, depart_addr
        FROM department
        ORDER BY depart_cd ASC
        """
    
      let rs = try self.fmdb.executeQuery(sql, values: nil)
      
      // 결과 추출
      while rs.next() {
        let departCd = rs.int(forColumn: "depart_cd") //return 자료형 Int32
        let departTitle = rs.string(forColumn: "depart_title")
        let departAddr = rs.string(forColumn: "depart_addr")
        
        // append 메소드 호출 시 아래 튜플 괄호 없이 사용하지 않도록 주의
        departList.append( (Int(departCd), departTitle!, departAddr!) )
      }
    } catch let error as NSError {
      print("\(error.localizedDescription)")
    }
    
    return departList
  }
  
  func get(departCd: Int) -> DepartRecord? {
    let sql = """
      SELECT depart_cd, depart_title, depart_addr
      FROM department
      WHERE depart_cd = ?
      """
    
    let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
    
    if let _rs = rs {
      _rs.next()
      
      let departId = _rs.int(forColumn: "depart_cd")
      let departTitle = _rs.string(forColumn: "depart_title")
      let departAddr = _rs.string(forColumn: "depart_addr")
      
      return (Int(departId), departTitle!, departAddr!)
    } else {
      return nil
    }
  }
  
  func create(title: String?, addr: String?) -> Bool {
    do {
      let sql = """
        INSERT INTO department (depart_title, depart_addr)
        VALUES (?, ?)
        """
      guard title != nil && title?.isEmpty == false,
            addr != nil && addr?.isEmpty == false else {return false}
      try self.fmdb.executeUpdate(sql, values: [title, addr])
      return true
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return false
    }
  }
  
  func remove(departCd: Int) -> Bool {
    do {
      let sql = "DELETE FROM department WHERE depart_cd = ?"
      try self.fmdb.executeUpdate(sql, values: [departCd])
      return true
    } catch let error as NSError {
      print("\(error.localizedDescription)")
      return false
    }
  }
}

