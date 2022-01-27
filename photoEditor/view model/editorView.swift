//
//  editorView.swift
//  photoEditor
//
//  Created by 楊昕蕾 on 2022/1/22.
//

import Foundation
import UIKit

class customEditView: UIScrollView{
    
    var btnW:CGFloat = 70{
        didSet{
            if btnW < 1{
                btnW = oldValue
            }
        }
    }
    
    var fontSize: CGFloat = 16{
        didSet{
            if fontSize < 12{
                fontSize = oldValue
            }
        }
    }
    
    
    var padding:CGFloat = 40{
        didSet{
            if padding < 5{
                padding = oldValue
            }
        }
    }
    
    var picH: CGFloat = 80
    var btnTitleFont = UIFont(name: "NotoSansTC-Medium", size: 16)
    var fontColor: UIColor = .white
    var btnBgColor: UIColor = .black
    var btnIndex: NSInteger = 0
    
    
    private var m_arybtns:[UIButton] = []
    private var m_aryTitleList:[String] = []
    private var m_aryPicList:[UIImage] = []
    private var m_completionHandler: ((_ index:Int)->(Void))?
    
    
    func setCustomEditView(titleList: [String], picList: [UIImage],completionHandler: @escaping((_ index:Int)->(Void))){
        self.m_completionHandler = completionHandler
        self.m_aryTitleList = titleList
        self.m_aryPicList = picList
        
        self.initScrollView()
        self.addPics()
        self.addBtn()
                
    }
    
    
    private func addBtn(){
        var x:CGFloat = 0.0
        let y:CGFloat = picH
        
        for (index, title) in (self.m_aryTitleList.enumerated()){
            //調整每個btn的x座標位置
            x = CGFloat(index) * self.btnW
            
            let btn:UIButton = UIButton(type: .custom)
            btn.tag = index
        
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(self.fontColor, for: .selected)
            btn.titleLabel?.font = self.btnTitleFont == nil ? UIFont.systemFont(ofSize: fontSize) : self.btnTitleFont
            btn.backgroundColor = self.btnBgColor
            btn.frame = CGRect(x: x + (padding * CGFloat(index)), y: y, width: self.btnW, height: self.frame.height - picH)
            btn.setTitleColor(.darkGray, for: .normal)
            
            btn.addTarget(self, action: #selector(customEditView.didTap(_:)), for: .touchUpInside)
            self.m_arybtns.append(btn)
            self.addSubview(btn)
            //設置scroll view的content size
            self.contentSize = CGSize(width: x + self.btnW + (padding * CGFloat(self.m_arybtns.count)) , height: 1)

                     
        }
        
     
    }
    
    
    func addPics(){
        var x:CGFloat = 0.0
        let y:CGFloat = 0.0
        
        for (index, _) in (self.m_aryPicList.enumerated()){
            x = CGFloat(index) * btnW
            let pic:UIImage = m_aryPicList[index]
            
            let picView = UIImageView(frame: CGRect(x: x + padding * CGFloat(index), y: y, width: self.btnW, height: self.picH))
            picView.image = pic
            picView.contentMode = .scaleAspectFit
            self.m_aryPicList.append(pic)
            self.addSubview(picView)
            picView.isUserInteractionEnabled = true
        }
        
    }
    
    func didSelect(index: NSInteger){
        guard self.m_arybtns.count > 0 else{
            return
        }
        let sender = self.m_arybtns[index]
        //取消選擇所有按鈕
        self.deselect()
        btnIndex = index
        sender.isSelected = true
        
        
        if self.m_completionHandler != nil{
            self.m_completionHandler!(sender.tag)
        }
        
    }
    
    private func deselect(){
        for btn in self.m_arybtns{
            btn.isSelected = false
        }
    }
    
    
    @objc fileprivate func didTap(_ sender: UIButton){
   
        self.didSelect(index: sender.tag)
    }
    

    
    private func initScrollView(){
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    

}
