//
//  extension.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/27.
//

import Foundation
import UIKit


extension UIImageView{
    
    var imgW:CGFloat{(self.image?.size.width)!}
    var imgH:CGFloat{(self.image?.size.height)!}
    var viewW:CGFloat{self.bounds.width}
    var viewH:CGFloat{self.bounds.height}
    var scale:CGFloat{min(viewW / imgW, viewH / imgH)}
    var offsetX:CGFloat{(viewW - imgW * scale) / 2}
    var offsetY:CGFloat{(viewH - imgH * scale) / 2}
    var scaledImgW:CGFloat{imgW * scale}
    var scaledImgH:CGFloat{imgH * scale}
    
    func getMaxX() -> CGFloat{
        return offsetX + imgW * scale
    }
    
    func getMaxY() -> CGFloat{
        return offsetY + imgH * scale
    }

}


extension UIImage{
    
    
    func applyFilter(filterName:String) -> UIImage {

        let ciImg = CIImage(image: self)
        let filter = CIFilter(name: filterName)
        filter?.setValue(ciImg, forKey: kCIInputImageKey)
        if let outputImg = filter?.outputImage,
           let cgImg = CIContext().createCGImage(outputImg, from: outputImg.extent){
            let outputUIImg = UIImage(cgImage: cgImg)
            return outputUIImg
        }else{
            return self
        }
    }
}

extension UIViewController{
    
    func render(cgRect:CGRect, imgView:UIView) -> UIImage{
        
        let renderer = UIGraphicsImageRenderer(bounds: cgRect)
        let editedImg = renderer.image{
            _ in
            imgView.drawHierarchy(in: imgView.bounds, afterScreenUpdates: true)
        }
        return editedImg
  
}
}

