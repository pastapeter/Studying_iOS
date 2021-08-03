//
//  ViewController.swift
//  NetworkingStudy
//
//  Created by abc on 2021/07/22.
//

import UIKit

class DataTaskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = [Book]()

    @IBAction private func sendRequest(_ sender: Any){
        let booksUrlStr = "https://kxcoding-study.azurewebsites.net/api/books"
        
        guard let url = URL(string: booksUrlStr) else {
            fatalError("invalid URL")
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("\(URLError.invalidResponse)")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("\(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                fatalError("\(URLError.invalidData)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
                    
                    let formatter = ISO8601DateFormatter()
                    formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
                    
                    return formatter.date(from: dateStr)!
                })
                let booklist = try decoder.decode(BookList.self, from: data)
                
                if booklist.code == 200 {
                    self.list = booklist.list
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension DataTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = list[indexPath.row]
        cell.textLabel?.text = target.title
        
        return cell
    }
    
    
}

extension DataTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = 
    }
}
