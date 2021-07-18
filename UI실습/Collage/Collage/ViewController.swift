//
//  ViewController.swift
//  Collage
//
//  Created by abc on 2021/02/13.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var numImage = 0
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var ImageList: [UIImage]?
    var flagImageSave = false
    
    
    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgvView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCapturePhoto(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            numImage = numImage + 1
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera")
        }
        
    }
    @IBAction func btnLoadPhoto(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
            numImage = numImage + 1
        } else {
            myAlert("PhotoLibrary inaccessible", message: "Application cannot access the photolibrary")
        }
    }
    @IBAction func btnReset(_ sender: UIButton) {
        imgView1.image = nil
        imgvView2.image = nil
        imgView3.image = nil
        numImage = 0
    }
    
    func myAlert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            if var ImageList = ImageList{
                ImageList.append(captureImage)
            }
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            if numImage % 3 == 1{
                imgView1.image = captureImage
            } else if numImage % 3 == 2 {
                imgvView2.image = captureImage
            } else if numImage % 3 == 0 {
                imgView3.image = captureImage
            }
//            if let ImageList = ImageList {
//                imgView1.image = ImageList[0]
//            }
//            if let img = ImageList{
//                if numImage == 1{
//                    imgView1.image = img[0]
//                } else if numImage == 2{
//                    imgView1.image = img[0]
//                    imgvView2.image = img[1]
//                } else if numImage == 3{
//                    imgView1.image = img[0]
//                    imgvView2.image = img[1]
//                    imgView3.image = img[2]
//                }
//            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if(numImage != 0){
            numImage = numImage - 1
        }
        self.dismiss(animated: true, completion: nil)
    }


}

