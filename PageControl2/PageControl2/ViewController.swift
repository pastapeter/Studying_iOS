//
//  ViewController.swift
//  PageControl2
//
//  Created by abc on 2021/02/04.
//

import UIKit

//let num = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
let total: Int = 10
class ViewController: UIViewController {
    @IBOutlet var lblNum: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = total
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        lblNum.text = String(1)
    }

    @IBAction func changePages(_ sender: UIPageControl) {
       // print(pageControl.currentPage)
        lblNum.text = String((pageControl.currentPage)+1)
    }
    
}

