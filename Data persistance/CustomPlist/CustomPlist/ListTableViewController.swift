//
//  ListTableViewController.swift
//  CustomPlist
//
//  Created by abc on 2021/08/27.
//

import UIKit

class ListTableViewController: UITableViewController, UIPickerViewDelegate {
  
  @IBOutlet weak var account: UITextField!
  @IBOutlet weak var gender: UISegmentedControl!
  @IBOutlet weak var married: UISwitch!
  @IBOutlet weak var name: UILabel!
  
  private var accountList: [String] = []
  var defaultPlist: NSDictionary!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let picker = UIPickerView()
    picker.delegate = self
    self.account.inputView = picker
    
    let toolbar = UIToolbar()
    toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
    toolbar.barTintColor = .lightGray
    
    self.account.inputAccessoryView = toolbar
    
    let done = UIBarButtonItem()
    done.title = "Done"
    done.target = self
    done.action = #selector(pickerDone)
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    let new = UIBarButtonItem()
    new.title = "New"
    new.target = self
    new.action = #selector(newAccount(_:))
    
    toolbar.setItems([new, flexSpace, done], animated: true)
    
    let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                 action: #selector(newAccount(_:)))
    self.navigationItem.rightBarButtonItems = [addBtn]
    
    let plist = UserDefaults.standard
    if let defaultPlistPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
      self.defaultPlist = NSDictionary(contentsOfFile: defaultPlistPath)
    }
//    name.text = plist.string(forKey: "name") ?? ""
//    married.isOn = plist.bool(forKey: "married")
//    gender.selectedSegmentIndex = plist.integer(forKey: "gender")
    
    let accountList = plist.array(forKey: "accountList") as? [String] ?? [String]()
    self.accountList = accountList
    
    if (self.account.text?.isEmpty)! {
      self.account.placeholder = "등록된계정이 없습니다."
      self.gender.isEnabled = false
      self.married.isEnabled = false
    }
    
    if let account = plist.string(forKey: "selectedAccount") {
      self.account.text = account
      let customPlist = "\(account).plist"
      let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      let path = paths[0] as NSString
      let plist = path.strings(byAppendingPaths: [customPlist]).first!
      let data = NSDictionary(contentsOfFile: plist)
      self.name.text = data?["name"] as? String
      self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
      self.married.isOn = data?["married"] as? Bool ?? false
    }
  }
  
  @IBAction private func changeGender(_ sender: UISegmentedControl) {
    let value = sender.selectedSegmentIndex
//    let plist = UserDefaults.standard
//    plist.set(value, forKey: "gender")
//    plist.synchronize()
    let customPlist = "\(account.text!).plist"
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let path = paths[0] as NSString
    let plist = path.strings(byAppendingPaths: [customPlist]).first!
    let data = NSMutableDictionary(contentsOfFile: plist) ??
      NSMutableDictionary(dictionary: self.defaultPlist)
    
    
    data.setValue(value, forKey: "gender")
    data.write(toFile: plist, atomically: true)
  }
  
  @IBAction private func changeMarried(_ sender: UISwitch) {
    let value = sender.isOn
//    let plist = UserDefaults.standard
//    plist.set(value, forKey: "married")
//    plist.synchronize()
    let customPlist = "\(self.account.text!).plist"
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let path = paths[0] as NSString
    let plist = path.strings(byAppendingPaths: [customPlist]).first!
    let data = NSMutableDictionary(contentsOfFile: plist) ??
      NSMutableDictionary(dictionary: self.defaultPlist)
    data.setValue(value, forKey: "married")
    data.write(toFile: plist, atomically: true)
    print("custom plist = \(plist)")
  }
  
  @objc private func newAccount(_ sender: Any) {
    self.view.endEditing(true)
    
    let alert = UIAlertController(title: "new Account", message: nil, preferredStyle: .alert)
    alert.addTextField { textfield in
      textfield.placeholder = "ex) abc@gmail.com"
    }
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
      if let account = alert.textFields?[0].text {
        self.accountList.append(account)
        self.account.text = account
        self.name.text = ""
        self.gender.selectedSegmentIndex = 0
        self.married.isOn = false
        
        let plist = UserDefaults.standard
        plist.set(self.accountList, forKey: "accountList")
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
        
        self.gender.isEnabled = true
        self.married.isEnabled = true
      }
    }))
    self.present(alert, animated: true, completion: nil)
  }
  @objc private func pickerDone(_ sender: Any){
    self.view.endEditing(true)
    
    if let _account = self.account.text {
      let customPlist = "\(_account).plist"
      let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      let path = paths[0] as NSString
      let plist = path.strings(byAppendingPaths: [customPlist]).first!
      let data = NSDictionary(contentsOfFile: plist)
      self.name.text = data?["name"] as? String
      self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
      self.married.isOn = data?["married"] as? Bool ?? false
    }
  }
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    super.numberOfSections(in: tableView)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return super.tableView(tableView, numberOfRowsInSection: section)
  }
}

extension ListTableViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return accountList.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return accountList[row]
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let account = accountList[row]
    self.account.text = account
    
    let plist = UserDefaults.standard
    plist.set(account, forKey: "selectedAccount")
    plist.synchronize()
  }
  
}

extension ListTableViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1  && !(self.account.text?.isEmpty)!{
      let alert = UIAlertController(title: nil, message: "add your name"
                                    , preferredStyle: .alert)
      alert.addTextField {
        $0.text = self.name.text
      }
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        let val = alert.textFields?[0].text
        //MARK: - USERDEFAULTS
//        let plist = UserDefaults.standard
//        plist.setValue(val, forKey: "name")
//        plist.synchronize()
        //MARK: - CUSTOMPList
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths.first! as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ??
          NSMutableDictionary(dictionary: self.defaultPlist)
        
        data.setValue(val, forKey: "name")
        data.write(toFile: plist, atomically: true)

        self.name.text = val
      }))
      self.present(alert, animated: true, completion: nil)
    }
  }
}
