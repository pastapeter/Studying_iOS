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
    var db: OpaquePointer? = nil
    var stmt: OpaquePointer? = nil
    
    let fileMgr = FileManager()
    let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
    let dbPath = try! docPathURL.appendingPathComponent("db.sqlite").path
    
    if fileMgr.fileExists(atPath: dbPath) == false {
      let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    //    let dbPath = "/Users/abc/db.sqlite"
    let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
    
    if sqlite3_open(dbPath, &db) == SQLITE_OK {
      if sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK {
        if sqlite3_step(stmt) == SQLITE_DONE {
          print("create table success")
        }
        sqlite3_finalize(stmt)
      } else {
        print("prepare statement fail")
      }
      sqlite3_close(db)
    } else {
      print("DB connect fail")
      return
    }
  }
  
  
}

