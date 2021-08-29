//
//  TutorialMasterVC.swift
//  tutorialPage
//
//  Created by abc on 2021/08/29.
//

import UIKit

class TutorialMasterVC: UIViewController {
  var pageVC: UIPageViewController!
  
  var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
  var contentImages = ["Page0", "Page1", "Page2", "Page3"]
  
  func getContentVC(atIndex idx: Int) -> UIViewController? {
    guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
      return nil
    }
    
    guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
      return nil
    }
    
    cvc.titleText = self.contentTitles[idx]
    cvc.imageFile = self.contentImages[idx]
    cvc.pageIndex = idx
    return cvc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //1 페이지뷰컨 객체 생성
    self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
    self.pageVC.dataSource = self
    
    //2 페이지뷰 컨트롤러의 기본페이지 지정
    let startContentVC = self.getContentVC(atIndex: 0)!
    self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true,
                                   completion: nil)
    
    //3 페이지뷰 컨트롤러의 출력 영역 지정
    self.pageVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width,
                                    height: self.view.frame.height - 50)
    
    //4 페이지뷰 컨를 마스터뷰 컨트롤러의 자식뷰 컨으로 설정
    self.addChild(self.pageVC) // 페이지 뷰컨을 자식뷰컨으로 등록
    self.view.addSubview(self.pageVC.view) //자식뷰컨을 현재의 서브뷰로 추가
    self.pageVC.didMove(toParent: self) //자식뷰컨에게 부모뷰컨이 바뀌었다는것을 알려줌

  }
  
  @IBAction func close(_ sender: UIButton) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }

}

extension TutorialMasterVC: UIPageViewControllerDataSource {
  // 현재 콘텐츠 뷰컨트롤러보다 앞쪽에 올 컨텐츠 뷰 컨트롤러 객체
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController)
  -> UIViewController? {
    guard var index = (viewController as! TutorialContentsVC).pageIndex else {
      return nil
    }
    guard index > 0 else {
      return nil
    }
    index -= 1
    return self.getContentVC(atIndex: index)
  }
  
  // 현재 콘텐츠 뷰컨트롤러보다 뒤쪽에 올 컨텐츠 뷰 컨트롤러 객체
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController)
  -> UIViewController? {
    guard var index = (viewController as! TutorialContentsVC).pageIndex else {
      return nil
    }
    index += 1
    guard index < self.contentTitles.count else {
      return nil
    }
    return self.getContentVC(atIndex: index)
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return self.contentTitles.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return 0
  }
  
}
