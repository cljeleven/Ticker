//
//  JCTicker.swift
//  JCTicker
//
//  Created by zexi chen on 2022-12-09.
//

import Foundation
import UIKit
//
//  TickerColumn.swift
//  JCTickerTests
//
//  Created by zexi chen on 2022-12-10.
//

import Foundation
import UIKit
import SpriteKit

public class UITicker: UIView {
    //basic setups
    let members = ["9", "8", "7", "6", "5", "4", "3", "2", "1", "0", " ",  "."]
    var animateTime = 1.0 //1 sec
    var tickerValue: [Int] = []
    
    //drawing
    var fullWidth = CGFloat(0)
    var targetPointX = CGFloat(0)
    var cellHeight = CGFloat(0)
    var colWidth = CGFloat(0)
    var colPadding = CGFloat(0)
    
    //text style
    var attrs: [NSAttributedString.Key : Any]?
    var textSize: CGSize = CGSize(width: 0, height: 0)
    var textStartY = CGFloat(0)
    
    //animation
    var displayLink: CADisplayLink?
    var startTime:CFTimeInterval = 0
    var animationProgress = 1.0
    var animateWidth = CGFloat(0)
    
    //columns
    var columns: [TickerColumn] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        //default text attributes
        let font=UIFont(name: "Helvetica", size: 32)!
        let text_style = NSMutableParagraphStyle()
        text_style.alignment = NSTextAlignment.center
        let text_color = UIColor.darkText
        attrs=[NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:text_style, NSAttributedString.Key.foregroundColor:text_color]
        
        self.textSize = "8".size(withAttributes: self.attrs)
        self.colPadding = textSize.width * CGFloat(0.05) //use 5% of width as total
        self.colWidth = textSize.width + colPadding
        
        
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.isPaused = true
        displayLink?.add(to: RunLoop.main, forMode: .common)
        
        //testing
        //  self.backgroundColor = .red
    }
    
    
    public override func draw(_ rect: CGRect) {
        let startPointX = (rect.width - self.fullWidth)/2 //start from the right side
        let animX = animationProgress * animateWidth
        
        //        columns[0].draw(rect, 0, animationProgress
        for (index, col) in columns.enumerated() {
            let startX = startPointX + CGFloat(index) * colWidth - animX
            col.draw(rect, startX, animationProgress)
        }
    }
}


extension UITicker {
    public func setValue(input: String) {
        let targets = parseString(input: input)
        self.tickerValue = targets
        self.fullWidth = CGFloat(targets.count) * colWidth
        columns.removeAll()
        targets.forEach { num in
            var newCol = TickerColumn(attrs)
            newCol.setTarget(target: num)
            columns.append(newCol)
        }
    }
    
    public func animateTo(target: String) {
        let targets = parseString(input: target)
        if(self.tickerValue.count != 0) {
            self.animateWidth = CGFloat(targets.count - self.tickerValue.count) * colWidth / 2
        } else {
            self.fullWidth = CGFloat(targets.count) * colWidth
        }
        
        self.tickerValue = targets
        updateCols(targets: targets)
        startAnimation()
    }
    
    func updateCols(targets: [Int]) {
        if(targets.count == columns.count) { //same length
            for (index, value) in targets.enumerated() {
                columns[index].setTarget(target: value)
            }
        } else if(targets.count > columns.count) { //need to add column
            for (index, value) in targets.enumerated() {
                if(index < columns.count) {
                    columns[index].setTarget(target: value)
                } else {
                    var newCol = TickerColumn(attrs)
                    newCol.setTarget(target: value)
                    columns.append(newCol)
                }
                
            }
        } else { //need to remove column
            for (index, col) in columns.enumerated() {
                if(index < targets.count) {
                    let newTarget = targets[index]
                    col.setTarget(target: newTarget)
                } else {
                    col.goToSpace()
                }
            }
        }
        
        
    }
}


//animation related
extension UITicker {
    
    public func setDurantion(_ second: Double) {
        self.animateTime = second
    }
    
    func startAnimation() {
        displayLink?.invalidate()
        let displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
        startTime = CACurrentMediaTime()
    }
    
    func stopDisplayLink() {
        displayLink?.invalidate()
    }
    
    @objc func update(_ displayLink: CADisplayLink) {
        //calculate next drawing point
        let currentTime = CACurrentMediaTime()
        let timeDiff = currentTime - startTime
        
        //    NSLog("timeDiff: \(timeDiff)")
        guard timeDiff <= self.animateTime else {
            finishAnimation()
            return
        }
        
        let interpolation = getInterpolation(percent: timeDiff / self.animateTime)
        
        //  NSLog("intepolation: \(interpolation)")
        self.animationProgress = interpolation
        
        //force redraw
        setNeedsDisplay()
    }
    //simple decreate interpolation
    func getInterpolation(percent: Double) -> Double {
        return (1.0 - pow(1.0 - percent , 5) )
    }
    
    func finishAnimation() {
        stopDisplayLink()
        self.fullWidth = CGFloat(self.tickerValue.count) * colWidth
        columns.forEach { col in
            col.finishHittingTarget()
        }
        columns.removeAll { col in
            col.isEmpty()
        }
        self.animationProgress = 1
        self.animateWidth = 0
        setNeedsDisplay()
    }
}


//parsing related
extension UITicker {
    
    func parseString(input: String) -> [Int] {
        var targets: [Int] = []
        let chars = Array(input)
        chars.forEach { c in
            let target = parseCharacter(char: c)
            targets.append(target)
        }
        return targets
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
    
    func setAttributes(_ attrs: [NSAttributedString.Key : Any]?) {
        self.attrs = attrs
        
    }
    
    
}
