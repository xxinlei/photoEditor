//
//  flip.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/24.
//

import Foundation
import UIKit

enum flip:Int, CaseIterable{
    case LRotation = 0
    case RRotation = 1
    case verticalFlip = 2
    case horizontalFlip = 3


    var icon:UIImage? {
        switch self{
        case .LRotation:
            return UIImage(named: "LRotation")
        case .RRotation:
            return UIImage(named: "RRotation")
        case .verticalFlip:
            return UIImage(named: "verticalFlip")
        case .horizontalFlip:
            return UIImage(named: "horizontalFlip")

        }
    }
}

