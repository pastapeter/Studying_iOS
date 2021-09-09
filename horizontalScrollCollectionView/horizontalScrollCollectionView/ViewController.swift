//
//  ViewController.swift
//  3DCarouselCollectionView
//
//  Created by abc on 2021/09/09.
//

import UIKit

class CaraouselCell: UICollectionViewCell {
  
  let customView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 30
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.customView)
    
    self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addCollectionView()
    collectionView.backgroundColor = .clear
    self.view.backgroundColor = .brown
  }
  
  func addCollectionView() {
    let layout = CarouselLayout()
    layout.itemSize = CGSize(width: collectionView.frame.size.width*0.796, height: collectionView.frame.size.height)
    layout.sideItemScale = 175/251
    layout.spacing = -197
    layout.isPagingEnabled = true
    layout.sideItemAlpha = 0.5
    
    collectionView.collectionViewLayout = layout
    
    self.collectionView?.delegate = self
    self.collectionView?.dataSource = self
    
    self.collectionView.register(CaraouselCell.self, forCellWithReuseIdentifier: "carouseCell")
  }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouseCell", for: indexPath)
     as! CaraouselCell
    cell.customView.backgroundColor = .white
    return cell
  }
  
  
}


