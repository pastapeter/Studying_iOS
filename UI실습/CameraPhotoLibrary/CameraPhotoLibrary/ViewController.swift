//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by abc on 2021/02/11.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let imagePicker: UIImagePickerController! = UIImagePickerController() //uiimagepickercontroller의 인스턴스 변수
    var captureImage: UIImage! //촬영을 하거나 포토라이브러리에서 불러온 사진을 저장할 변수
    var videoURL: URL! // 녹화한 비디오의 URL을 저장할 변수
    var flagImageSave  = false // 이미지 저장여부 판단 flag
    
    @IBOutlet var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func myAlert(_ title: String, message: String){
        let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let Action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        Alert.addAction(Action)
        self.present(Alert, animated: true, completion: nil)
    }
    
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            
            imagePicker.delegate = self //이미지피커의 일을 대행해줄 놈은 뷰컨이다.
            imagePicker.sourceType = .camera // 소스타입을 카메라로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String] //이미지타입은 kuttypeimage인데 그것을 문자열 타입으로 저장
            imagePicker.allowsEditing = false // 편집허용 X
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰컨을 이미지피커로 변경 -> 이미지피커가 보여지게
        }
        else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera.")
        }
    }
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true // 이게 큰 다른점
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo Album inaccessible", message: "Application cannot access the photo Albums")
        }
    }
    @IBAction func btnCaptureVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            
            imagePicker.delegate = self //이미지피커의 일을 대행해줄 놈은 뷰컨이다.
            imagePicker.sourceType = .camera // 소스타입을 카메라로 설정
            imagePicker.mediaTypes = [kUTTypeMovie as String] //이미지타입은 kuttypemovie인데 그것을 문자열 타입으로 저장
            imagePicker.allowsEditing = false // 편집허용 X
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰컨을 이미지피커로 변경 -> 이미지피커가 보여지게
        }
        else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera.")
        }
    }
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true // 이게 큰 다른점
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo Album inaccessible", message: "Application cannot access the photo Albums")
        }
    }
 
    //사진이나 비디오 촬영이 끝났을때 호출되는 델리게이트 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어 종류를 파악한다.
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
        }
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String){
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        self.dismiss(animated: true, completion:nil)
    }
    
    // 사용자가 사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 취소를 하는 경우에 호출되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

