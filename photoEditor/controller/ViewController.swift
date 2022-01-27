//
//  ViewController.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/20.
//

import UIKit
import PhotosUI


var img: UIImage?

class ViewController: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loadPhoto(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        
//        可選數量，預設為1，0為不限制
//        configuration.selectionLimit = 1
        
        //可選的類型（images包含livePhotos）
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func takeAPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBSegueAction func showEditor(_ coder: NSCoder) -> UIViewController? {
        let selectedPhoto = img
        let nextVC = editPhotoVC(coder: coder)
        nextVC?.selectedImg = selectedPhoto
        return nextVC
    }
}


extension UIViewController:PHPickerViewControllerDelegate {
    
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //首先dismiss picker
        picker.dismiss(animated: true, completion: nil)
        
        let itemProviders = results.map(\.itemProvider)
        
        if let itemProvider = itemProviders.first,
           itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self){ (data, error) in
                if  let image = data as? UIImage{
                    DispatchQueue.main.async {
                        img = image
                        
                            self.performSegue(withIdentifier: "showEditor", sender: nil)
                        
                    }
                }
            }
        
                    }
        
    }
}

extension UIViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        img = image
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "showEditor", sender: nil)
    }
}
