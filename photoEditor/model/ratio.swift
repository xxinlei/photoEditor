//
//  ratio.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/23.
//

import Foundation
import UIKit

enum ratio:Int, CaseIterable{
    case original = 0
    case ratio11 = 1
    case ratio43 = 2
    case ratio32 = 3
    case ratio53 = 4
    case ratio169 = 5

    var pic:UIImage? {
        switch self{
        case .original:
            return UIImage(named: "original")
        case .ratio11:
            return UIImage(named: "1-1")
        case .ratio43:
            return UIImage(named: "4-3")
        case .ratio32:
            return UIImage(named: "3-2")
        case .ratio53:
            return UIImage(named: "5-3")
        case .ratio169:
            return UIImage(named: "16-9")
        }
    }
    
    var ratioValue:CGFloat?{
        switch self{
        case .original:
            return 1.0
        case .ratio11:
            return 1.0
        case .ratio43:
            return 1 / 4 * 3
        case .ratio32:
            return 1 / 3 * 2
        case .ratio53:
            return 1 / 5 * 3
        case .ratio169:
            return 1 / 16 * 9
        }
    }
}
