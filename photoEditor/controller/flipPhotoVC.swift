//
//  flipPhotoVC.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/25.
//

import UIKit

protocol flipPhotoVCDelegate{
    func flipPhotoVC(_ controller:flipPhotoVC, didFlip flippedImg:UIImage)

}

class flipPhotoVC: UIViewController {

    @IBOutlet weak var flipImgView: UIImageView!

    @IBOutlet weak var flipEditView: customEditView!
    
    var selectedPhoto:UIImage?
    let flipTitleList = ["向左90º", "向右90º", "水平", "鏡像"]
    var flipPicList:[UIImage] = []
    var rotateCount = 0
    var horizontalFlipX = 1
    var horizontalFlipY = 1
    let oneDegree = CGFloat.pi / 180
    var transform:CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)
    var delegate:flipPhotoVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flipImgView.image = selectedPhoto
        
        flipEditView.padding = 15
        flipEditView.picH = 45
        
        for i in 0...flip.allCases.count-1{
            let icon = flip(rawValue: i)?.icon
            flipPicList.append(icon!)
        }
        
        flipEditView.setCustomEditView(titleList: flipTitleList, picList: flipPicList){ [self] (index) -> (Void) in
            print(index)
            

                switch index{
                case 0:
                    rotateCount -= 1
 
                case 1:
                    rotateCount += 1

                case 2:
                    if rotateCount % 2 == 1{
                        horizontalFlipX *= -1
                    }else{
                        horizontalFlipY *= -1
                    }

                case 3:
                    if rotateCount % 2 == 1{
                        horizontalFlipY *= -1
                    }else{
                        horizontalFlipX *= -1
                    }
                    
                default:
                    break
                }
            
            let rotation = CGAffineTransform(rotationAngle: oneDegree * 90 * CGFloat(rotateCount))
            let horizontalTransform = CGAffineTransform(scaleX: 1 * CGFloat(horizontalFlipX), y: 1 * CGFloat(horizontalFlipY))
        
            transform = horizontalTransform.concatenating(rotation)
            flipImgView.transform = transform
            
        }
    }
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        guard flipImgView.image != nil else{return}
            
  
        let flippedImgRect = CGRect(x: flipImgView.offsetX, y: flipImgView.offsetY, width: flipImgView.imgW * flipImgView.scale, height: flipImgView.imgH * flipImgView.scale)
            
            let newRect = flipImgView.convert(flippedImgRect, to: self.view)
            
            let flippedImg = render(cgRect: newRect, imgView: self.view)
            
            delegate?.flipPhotoVC(self, didFlip: flippedImg)
            self.dismiss(animated: true, completion: nil)
        

        
    }
}


