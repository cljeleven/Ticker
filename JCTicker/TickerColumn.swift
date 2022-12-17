//
//  TickerColumn.swift
//  JCTickerTests
//
//  Created by zexi chen on 2022-12-10.
//

import Foundation
import UIKit
import SpriteKit

public class TickerColumn {
    //basic setups
    let members = ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0", " ",  " "] //remove . for now
    var animateTime = 1.0 //1 sec
    var current = 10 //10 is space
    var target = 10
    
    //drawing
    var fullSize = CGFloat(0)
    var startPoint = CGFloat(0)
    var targetPoint = CGFloat(0)
    var cellHeight = CGFloat(0)
    
    //text style
    var attrs: [NSAttributedString.Key : Any]?
    var textSize: CGSize = CGSize(width: 0, height: 0)
    var textStartY = CGFloat(0)
    var dotSize: CGSize = CGSize(width: 0, height: 0)
    
    //default setup
    convenience init() {
        //default text attributes
        let font=UIFont(name: "Helvetica", size: 32)!
        let text_style = NSMutableParagraphStyle()
        text_style.alignment = NSTextAlignment.center
        let text_color = UIColor.darkText
        let attrs=[NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:text_style, NSAttributedString.Key.foregroundColor:text_color]
        self.init(attrs)
        
    }
    
    //init with text style and initial value
    init(_ textStyleAttrs: [NSAttributedString.Key : Any]?) {
        self.attrs = textStyleAttrs
        self.textSize = "8".size(withAttributes: self.attrs)
        self.dotSize = ".".size(withAttributes: self.attrs)
    }
    
    
    public func draw(_ rect: CGRect, _ startX: CGFloat, _ animationProgress: Double) {
        self.cellHeight = rect.height
        self.fullSize = cellHeight * 12//0-9 + space and "."
        let targetDiffY = CGFloat(current - target) * cellHeight
        let currentMove = targetDiffY * animationProgress
        
        startPoint = calculateStartingPos(rect.height)
        targetPoint = calculateTargetPos(rect.height)
        //draw from space to 9, but only need to draw the 3(or 2) needed
        /*
         display only 5, or the 4,5 or 5,6 if they are in frame
         ..
         6
         [5]
         4
         ..
         */
        // NSLog("rect height : \(rect.height)")
        NSLog("printing start at \(startPoint) startPoint: \(startPoint), cellHeight = \(cellHeight), currentMove = \(currentMove)")
        for (index, element) in members.enumerated() {
            
            let currentStartY = startPoint + cellHeight * CGFloat(index) + currentMove
            let currentEndY = currentStartY + cellHeight
            
            //check if this element is visible
            guard currentStartY >= 0 && currentStartY < cellHeight ||
                    currentEndY > 0 && currentEndY <= cellHeight else {
                continue
            }
            
            //print the text
            NSLog("printing \(element)")
            element.draw(at: CGPoint(
                x:startX + (element == "." ? (textSize.width-dotSize.width)/2 : (textSize.width-element.size(withAttributes: self.attrs).width)/2),
                y:currentStartY + (rect.height - textSize.height)/2 + textStartY),
                         withAttributes: attrs)
        }
        
        
    }
    
}

extension TickerColumn {
    public func setValue(char: Character) {
        self.current = parseCharacter(char: char)
        self.target = self.current
    }
    public func setValue(value: Int) {
        self.current = value
        self.target = self.current
    }
    
    public func setTarget(char: Character) {
        self.target = parseCharacter(char: char)
    }
    public func setTarget(target: Int) {
        self.target = target
        
    }
    public func goToSpace() {
        self.target = 10
    }
    
    //no need to
    func parseCharacter(char: Character) -> Int {
        var current = 0
        switch char {
        case ".": current = 11
            //skip empty
        case "0": current = 9
        case "1": current = 8
        case "2": current = 7
        case "3": current = 6
        case "4": current = 5
        case "5": current = 4
        case "6": current = 3
        case "7": current = 2
        case "8": current = 1
        case "9": current = 0
            
        default:
            current = 10
        }
        
        return current
    }
    
    func finishHittingTarget() {
        current = target
    }
    
    func isEmpty() -> Bool {
        return self.current == 10
        
    }
    
    func calculateStartingPos(_ cellHeight: CGFloat) -> CGFloat {
        return -cellHeight * CGFloat(current)
    }
    func calculateTargetPos(_ cellHeight: CGFloat) -> CGFloat {
        return -cellHeight * CGFloat(target)
    }
    func setAttributes(_ attrs: [NSAttributedString.Key : Any]?) {
        self.attrs = attrs
        
    }
    
    
}
