//
//  colorFilter.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/25.
//

import Foundation


enum filter:String, CaseIterable{
    case original = ""
    case CIPhotoEffectChrome = "CIPhotoEffectChrome"
    case CIPhotoEffectFade = "CIPhotoEffectFade"
    case CIPhotoEffectInstant = "CIPhotoEffectInstant"
    case CIPhotoEffectTransfer = "CIPhotoEffectTransfer"
    case CISepiaTone = "CISepiaTone"
    case CIBoxBlur = "CIBoxBlur"
    case CIPhotoEffectMono = "CIPhotoEffectMono"
    case CIPhotoEffectNoir = "CIPhotoEffectNoir"
    
     
    var filterName:String{
        switch self{
        case .original:
            return "原圖"
        case .CIPhotoEffectChrome:
            return "Chrome"
        case .CIPhotoEffectFade:
            return "Fade"
        case .CIPhotoEffectInstant:
            return "Instant"
        case .CIPhotoEffectTransfer:
            return "Transfer"
        case .CISepiaTone:
            return "Sepia"
        case .CIBoxBlur:
            return "Blur"
        case .CIPhotoEffectMono:
            return "Mono"
        case .CIPhotoEffectNoir:
            return "Noir"
        }
    }

}


