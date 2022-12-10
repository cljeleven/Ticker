//
//  JCTicker.swift
//  JCTicker
//
//  Created by zexi chen on 2022-12-09.
//

import Foundation
import UIKit

public class JCTicker:UIView {
    
    var cols: [String] = []
    
 
    override init(frame: CGRect) {
       super.init(frame: frame)
        setupView()
     }
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    func setupView() {
        self.backgroundColor = UIColor.red
    }
    
    public func setColumn(cols: [String]) {
        self.cols = cols
    }
    
    
    
    
    public override func draw(_ rect: CGRect) {
    
        let text:NSString = "1234"

                   //text attributes
                   let font=UIFont(name: "Helvetica-Bold", size: 32)!
                   let text_style=NSMutableParagraphStyle()
                   text_style.alignment=NSTextAlignment.center
                   let text_color=UIColor.blue
                let attributes=[NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:text_style, NSAttributedString.Key.foregroundColor:text_color]

                   //vertically center (depending on font)

//                   text.draw(in: rect, withAttributes: attributes)
        text.draw(at: CGPoint(x:rect.width/2,y:-10), withAttributes: attributes)
        
    
        
     }
//
//    public override func draw(_ rect: CGRect) {
//

//
//
//    }
//
    
    
    
    
    
}
