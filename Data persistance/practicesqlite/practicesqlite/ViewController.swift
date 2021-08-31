//
//  ViewController.swift
//  practicesqlite
//
//  Created by abc on 2021/08/26.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dbPath = getDBPath()
    dbExecute(dbPath: dbPath)
  }
  
  private func getDBPath() -> String {
    let fileMgr = FileManager()
    let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
    let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
    
    // dbpath 경로에 파일이없다면?
    if fileMgr.fileExists(atPath: dbPath) == false {
      let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    return dbPath
  }
  
  private func dbExecute(dbPath: String) {
    var db: OpaquePointer? = nil
    guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
      print("DB connect fail")
      return
    }
    defer {
      print("Close Database Connection")
      sqlite3_close(db)
    }
    var stmt: OpaquePointer? = nil
    let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
    guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      print("prepare statement fail")
      return
    }
    defer {
      print("Finalize Statement")
      sqlite3_finalize(stmt)
    }
    if sqlite3_step(stmt) == SQLITE_DONE {
      print("create table success")
    }
  }
}

