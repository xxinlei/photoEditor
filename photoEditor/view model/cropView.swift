//
//  cropView.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/23.
//

import Foundation
import UIKit

class crop:UIView{
    
    override func draw(_ rect:CGRect){
        //畫外框
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        //畫格線
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 0, y: rect.maxY / 3))
        line.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
        line.move(to: CGPoint(x: 0, y: rect.maxY / 3 * 2))
        line.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3 * 2))
        line.move(to: CGPoint(x: rect.maxX / 3, y: 0))
        line.addLine(to: CGPoint(x: rect.maxX / 3, y: rect.maxY))
        line.move(to: CGPoint(x: rect.maxX / 3 * 2, y: 0))
        line.addLine(to: CGPoint(x: rect.maxX / 3 * 2, y: rect.maxY))
        //四個角外框加粗
        let corner = UIBezierPath()
        //左上
        corner.move(to: CGPoint(x: 0, y: 0))
        corner.addLine(to: CGPoint(x: 0, y: rect.maxY / 9))
        corner.move(to: CGPoint(x: 0, y: 0))
        corner.addLine(to: CGPoint(x: rect.maxX / 9, y: 0))
        //右上
        corner.move(to: CGPoint(x: rect.maxX, y: 0))
        corner.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 9))
        corner.move(to: CGPoint(x: rect.maxX, y: 0))
        corner.addLine(to: CGPoint(x: rect.maxX / 9 * 8, y: 0))
        //左下
        corner.move(to: CGPoint(x: 0, y: rect.maxY))
        corner.addLine(to: CGPoint(x: rect.maxX / 9, y: rect.maxY))
        corner.move(to: CGPoint(x: 0, y: rect.maxY))
        corner.addLine(to: CGPoint(x: 0, y: rect.maxY / 9 * 8))
        //右下
        corner.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        corner.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 9 * 8))
        corner.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        corner.addLine(to: CGPoint(x: rect.maxX / 9 * 8, y: rect.maxY))

        //設置線條顏色及粗細
        UIColor(red: 1, green: 1, blue: 1, alpha: 1).setStroke()
        path.lineWidth = 2
        line.lineWidth = 1
        corner.lineWidth = 4
        path.stroke()
        line.stroke()
        corner.stroke()
        
    }
    
}
