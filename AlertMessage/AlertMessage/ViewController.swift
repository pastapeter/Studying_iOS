//
//  ViewController.swift
//  AlertMessage
//
//  Created by abc on 2021/02/02.
//

import UIKit

class ViewController: UIViewController {
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    var isLampOn = true

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = imgOn
    }

    @IBAction func btnLampOn(_ sender: UIButton) {
        if(isLampOn == false){
            imageView.image = imgOn
            isLampOn = true
        } else {
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 ON 상태입니다", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "네 알겠습니다", style: UIAlertAction.Style.default, handler: nil)
            lampOnAlert.addAction(onAction)
            present(lampOnAlert, animated: true, completion: nil)
        }
    }
    @IBAction func btnLampOff(_ sender: UIButton) {
        if(isLampOn == true){
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {ACTION in self.imageView.image = self.imgOff
                self.isLampOn = false })
            let cancelAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil)
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let offAction = UIAlertAction(title: "아니오 끕니다", style: UIAlertAction.Style.default, handler: {ACTION in self.imageView.image = self.imgOff
            self.isLampOn = false
        })
        let onAction = UIAlertAction(title: "아니오 켭니다", style: UIAlertAction.Style.default, handler: {ACTION in self.imageView.image = self.imgOn
            self.isLampOn = true
        })
        let RemoveAction = UIAlertAction(title: "네 제거하겠습니다", style: UIAlertAction.Style.destructive, handler: {ACTION in self.imageView.image = self.imgRemove
            self.isLampOn  = false
        })
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(RemoveAction)
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

