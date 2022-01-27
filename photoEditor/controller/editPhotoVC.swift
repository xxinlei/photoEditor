//
//  editPhotoVC.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/22.
//

import UIKit
import CoreImage.CIFilterBuiltins


class editPhotoVC: UIViewController{

    var selectedImg:UIImage?
 
    @IBOutlet weak var colorFilter: customEditView!
    @IBOutlet weak var editImgView: UIImageView!
    var filterTitleList:[String] = []
    var filterIconList:[UIImage] = []
    var editedImg:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        editImgView.image = selectedImg!
        
        //加入所有filter的title
        for i in 0...filter.allCases.count-1{
            let filterName = filter.allCases[i].filterName
            filterTitleList.append(filterName)
        }
        
        //加入跟filter數量相應的圖片作為filter縮圖，每一張都加上對應的濾鏡
        for i in 0...filter.allCases.count-1{
            filterIconList.append((editedImg ?? selectedImg)!)
            let filteredIcon = filterIconList[i].applyFilter(filterName: filter.allCases[i].rawValue)
            filterIconList[i] = filteredIcon
        }
    }
    
    
    @IBAction func showColorFilter(_ sender: UIButton) {
        
        sender.isUserInteractionEnabled = false
        colorFilter.setCustomEditView(titleList: filterTitleList, picList: filterIconList){ (index) -> (Void) in
            
            let selectedFilter = filter.allCases[index].rawValue
            let outputImg = (self.editedImg ?? self.selectedImg)!.applyFilter(filterName: selectedFilter)
            self.editImgView.image = outputImg
    
        }
    }
    
    
    @IBAction func download(_ sender: Any) {
        guard editedImg != nil else {
            return
        }

        let w = editImgView.imgW * editImgView.scale
        let h = editImgView.imgH * editImgView.scale
        
        let newRect = editImgView.convert(CGRect(x: editImgView.offsetX, y: editImgView.offsetY, width: w, height: h), to: self.view)
        
        let downloadImg = render(cgRect: newRect, imgView: self.view)
        let activityVC = UIActivityViewController(activityItems: [downloadImg], applicationActivities: nil)
        

        activityVC.completionWithItemsHandler = {(activiType: UIActivity.ActivityType?, completed: Bool, returnItems: [Any]?, error:Error?) in

            if error != nil{
                //待新增
            }
        }
        self.present(activityVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBSegueAction func goToCrop(_ coder: NSCoder) -> cropPhotoVC? {
        let selectedPhoto = editImgView.image
        let cropVC = photoEditor.cropPhotoVC(coder: coder)
        cropVC?.delegate = self
        cropVC?.selectedPhoto = selectedPhoto
        
        return cropVC
    }
    
    
    @IBSegueAction func goToFlip(_ coder: NSCoder) -> flipPhotoVC? {
        
        let selectedPhoto = editImgView.image
        let flipVC = photoEditor.flipPhotoVC(coder: coder)
        flipVC?.delegate = self
        flipVC?.selectedPhoto = selectedPhoto
        return flipVC
    }
}

extension editPhotoVC: cropPhotoVCDelegate ,flipPhotoVCDelegate{


    func cropPhotoVC(_ controller: cropPhotoVC, didCrop croppedImg: UIImage) {
        editImgView.image = croppedImg
        editedImg = croppedImg

    }
    
    func flipPhotoVC(_ controller: flipPhotoVC, didFlip flippedImg: UIImage){
        editImgView.image = flippedImg
        editedImg = flippedImg
    }
    

}


