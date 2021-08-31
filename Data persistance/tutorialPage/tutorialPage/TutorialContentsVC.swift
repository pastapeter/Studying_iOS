//
//  TutorialContentsVC.swift
//  tutorialPage
//
//  Created by abc on 2021/08/29.
//

import UIKit

class TutorialContentsVC: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bgImageView: UIImageView!
  
  var pageIndex: Int!
  var titleText: String!
  var imageFile: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bgImageView.contentMode = .scaleToFill
    self.titleLabel.text = self.titleText
    self.titleLabel.sizeToFit()
    
    self.bgImageView.image = UIImage(named: self.imageFile)
    
    // Do any additional setup after loading the view.
  }
  
}
