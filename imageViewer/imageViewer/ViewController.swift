//
//  ViewController.swift
//  imageViewer
//
//  Created by abc on 2021/01/31.
//

import UIKit

class ViewController: UIViewController {
    
    var numImage: Int = 1
    var maxImage: Int = 6
   // var isPrevious = false
   // var isNext = false
    

    @IBOutlet var imageViewer: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "1.png")
    }
    
    
    @IBAction func previousImg(_ sender: UIButton) {
        numImage = numImage - 1
        if(numImage < 1){
            numImage = maxImage
        }
        let imageName = String(numImage) + ".png"
        imageView.image = UIImage(named:imageName)
    }

    @IBAction func nextImg(_ sender: UIButton) {
        numImage = numImage + 1
        if(numImage > maxImage){
            numImage = 1
        }
        let imageName = String(numImage) + ".png"
        imageView.image = UIImage(named: imageName)

    }
//    @IBAction func nextImg(_ sender: UIButton) {
//        if(numImage > maxImage){
//            numImage = 1
//        }
//        else {
//            numImage = numImage + 1
//        }
//        let imageName = String(numImage) + ".jpeg"
//        imageView.image = UIImage(named: imageName)
        
    //}

}

