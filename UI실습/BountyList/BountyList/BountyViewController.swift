//
//  BountyViewController.swift
//  BountyList
//
//  Created by abc on 2021/01/25.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MVVM
    
    // MODEL
    // -BountyInfo
    // > Bountyinfo 만들자
    
    // View
    // -ListCell
    // >ListCell 필요한 정보를 viewmodel한테서 받아야겟다
    // >ListCell은 viewmodel부터 받은정보로 뷰 업데이트하기
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기, Bountyinfo들을 가지고 있어야함
    
    
    let viewModel = BountyViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 세그웨이 수행 준비할때 데이터를 넘겨주자
        // Detailviewcontroller에게 데이터 줄거에요
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model:bountyInfo)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //UICollectionViewDataSource
    // 몇개를 보여줄까요
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까요??
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {return UICollectionViewCell()}
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
            //cell.update(info: bountyInfo)
        cell.update(info: bountyInfo)
        return cell
    }
    
    //UICollectionViewDelegate
    // 셀이 클릭되었을때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    //UICollectionViewDelegateFlowLayout
    // cell size를 계산할것이다 (목표: 다양한 디바이스에서 균형적인, 일관적인 디자인을 보여주기 위해)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
    
//    // UITableViewDataSource : 몇개니>\?
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numOfBountyInfoList
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
////            return UITableViewCell()
////        }
////        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
////        cell.imgView.image = img
////        cell.nameLabel.text = nameList[indexPath.row]
////        cell.bountyLable.text = "\(bountyList[indexPath.row])"
////        return cell
//        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell{
//            cell.update(info: bountyInfo)
//            return cell
//        }
//        else{
//            return UITableViewCell()
//        }
//    }
//
//    //UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("--> \(indexPath.row)")
//        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
//    }
}

//class ListCell: UITableViewCell {
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var bountyLable: UILabel!
//
//    func update(info: BountyInfo){
//        imgView.image = info.image
//        nameLabel.text = info.name
//       bountyLable.text = "\(info.bounty)"
//    }
//}

class BountyViewModel{
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 12000000),
    ]
    
    var sortedList: [BountyInfo] {
       let sortedList =  bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList : Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int)-> BountyInfo {
        return sortedList[index]
    }
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLable: UILabel!
    
    func update(info: BountyInfo){
        imgView.image = info.image
        nameLabel.text = info.name
       bountyLable.text = "\(info.bounty)"
    }
}
