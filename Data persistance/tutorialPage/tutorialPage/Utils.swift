//
//  Utils.swift
//  tutorialPage
//
//  Created by abc on 2021/08/29.
//

import UIKit

extension UIViewController {
  var tutorialSB: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
  }
  
  func instanceTutorialVC(name: String) -> UIViewController? {
    return self.tutorialSB.instantiateViewController(identifier: name)
  }
}
