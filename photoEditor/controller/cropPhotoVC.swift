//
//  cropPhotoVC.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/23.
//

import UIKit

protocol cropPhotoVCDelegate{
    func cropPhotoVC(_ controller:cropPhotoVC, didCrop croppedImg:UIImage)
}

class cropPhotoVC: UIViewController {
    
 
    @IBOutlet weak var cropEditView: customEditView!
    @IBOutlet weak var cropImgView: UIImageView!
    
    var selectedPhoto:UIImage?
    var cropFrame:crop?
    
    let ratioList = ["原圖", "1:1", "4:3", "3:2", "5:3", "16:9"]
    var picList:[UIImage] = []
    var value:CGFloat = 1.0
    
    var delegate:cropPhotoVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        cropImgView.image = selectedPhoto
        let cropFrameRect = CGRect(x: cropImgView.offsetX, y: cropImgView.offsetY, width: cropImgView.imgW * cropImgView.scale, height: cropImgView.imgH * cropImgView.scale)
        cropFrame = crop(frame: cropFrameRect)
        
        cropFrame?.backgroundColor = .clear
        cropImgView.addSubview(cropFrame!)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        cropImgView.isUserInteractionEnabled = true
        cropImgView.addGestureRecognizer(pinch)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        cropFrame!.addGestureRecognizer(pan)
      
        //加入裁切圖標
        for i in 0...ratio.allCases.count-1{
            let image = ratio(rawValue: i)?.pic
            picList.append(image!)
        }
         
        
        cropEditView.setCustomEditView(titleList: ratioList, picList: picList){ [self] (index) -> (Void) in
            
    
            if let aspectRatio = ratio(rawValue: index)?.ratioValue,
               let h = cropFrame?.frame.size.height,
               let w = cropFrame?.frame.size.width{
                
                guard index == 0 else{
                    value = aspectRatio
                    cropFrame?.frame.size.width = h / aspectRatio
                    return
                }
                
                let originalRatio:CGFloat = cropImgView.imgH / cropImgView.imgW
    
                cropFrame?.frame.size.height = w * originalRatio
                value = originalRatio
            }
        }
        }

    
    @objc func didPan(_ gestureRecognizer:UIPanGestureRecognizer){
        
        let translation = gestureRecognizer.translation(in: cropImgView)
        let offsetX = cropImgView.offsetX
        let offsetY = cropImgView.offsetY
        var overrunX:CGFloat = 0.0
        var overrunY:CGFloat = 0.0
        
        //左
        var newX:CGFloat = 0.0{
            didSet{
                if newX < offsetX{newX = offsetX}
            }
        }
        //右
        var newMaxX:CGFloat = 0.0{
            didSet{
                if newMaxX < cropImgView.getMaxX(){
                    overrunX = 0}
                else{
                    if translation.x * -1 > 0{
                        overrunX = 0}
                    else{
                        overrunX = translation.x}
                }
            }
        }
        
        //上
        var newY:CGFloat = 0.0{
            didSet{
                if newY < offsetY{
                    newY = offsetY}
            }
        }
        
        //下
        var newMaxY:CGFloat = 0.0{
            didSet{
                if newMaxY < cropImgView.getMaxY(){
                    overrunY = 0
                }
                else{
                    if translation.y * -1 > 0{
                        overrunY = 0
                    }else{
                        overrunY = translation.y
                    }
            }
        }
        }

        newX = (cropFrame?.frame.origin.x)!
        newY = (cropFrame?.frame.origin.y)!
        newMaxX = overrunX > 0 ? cropImgView.getMaxX() : (cropFrame?.frame.maxX)!
        newMaxY = overrunY > 0 ? cropImgView.getMaxY() : (cropFrame?.frame.maxY)!
  
        cropFrame?.transform = CGAffineTransform(translationX: newX + translation.x - overrunX - offsetX, y: newY + translation.y - overrunY - offsetY)
        gestureRecognizer.setTranslation(CGPoint.zero, in: cropImgView)

    }


    @objc func didPinch(_ gestureRecognizer:UIPinchGestureRecognizer){
        if gestureRecognizer.state == .changed{
            
            let pinchScale = gestureRecognizer.scale
            if let cropFrame = cropFrame {
                let cropW = cropFrame.frame.size.width
                let cropH = cropFrame.frame.size.height
                
                var scaleW:CGFloat{cropW * pinchScale}
                var scaleH:CGFloat{cropH * pinchScale}
                                        
               
                guard scaleW / value < cropImgView.scaledImgW &&
                        scaleH * value < cropImgView.scaledImgH else{
                            return
                        }
                cropFrame.frame.size.width = scaleW / value
                cropFrame.frame.size.height = scaleW
            }
 
                }
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        cropFrame?.removeFromSuperview()
        
        guard let cropFrame = cropFrame else{return}
        let editedImg = render(cgRect: CGRect(x: cropFrame.frame.minX, y: cropFrame.frame.minY, width: cropFrame.frame.width, height: cropFrame.frame.height), imgView: cropImgView)
        
        delegate?.cropPhotoVC(self, didCrop: editedImg)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}




