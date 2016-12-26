//
//  PieTouchView.swift
//  PiChart
//
//  Created by Connor Stout on 8/31/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class PieChart: UIView {
    var centerX:Double = 0
    var centerY:Double = 0
    var radius:Double = 0
    var percentages:[Double] = [1]
    var names:[String] = ["Nothing"]
    var colors:[Int] = [7]
    var hasKey = false
    var colorScheme:[UIColor]=[]
    var c = ColorObject()
    var chartCenter:CGPoint = CGPoint()
    init(frame: CGRect, percentage:[Double],names:[String], color:[Int]) {
        super.init(frame: frame)
        var c = ColorObject()
        colorScheme = c.pieArray()
        if(color.count>0){
            hasKey = true
            percentages = percentage
            self.names = names
            self.colors = color
        }
        radius = Double(self.frame.size.width/2-10)
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.center.x)
        centerY = Double(radius+10)
        chartCenter = CGPointMake(CGFloat(centerX), CGFloat(centerY))
 
    }
    init(frame: CGRect, percentage:[Double], color:[Int]) {
        var c = ColorObject()
        colorScheme = c.pieArray()
        hasKey = true
        super.init(frame: frame)
        percentages = percentage
        radius = Double(self.frame.size.width/2-10)
        self.colors = color
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.center.x)
        centerY = Double(radius+10)
        chartCenter = CGPointMake(CGFloat(centerX), CGFloat(centerY))
        
    }
    init() {
    
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        
        drawLines()
        if(hasKey){
            addKey()
        }
        
    }
    
    func drawLines() {
        var totalAngle:CGFloat = 0
        
        for(var i = 0;i<percentages.count;i++){
            var thisAngle = percentages[i]*2*M_PI
            var myBezier = UIBezierPath()
            myBezier.moveToPoint(chartCenter)
            myBezier.addArcWithCenter(chartCenter, radius:CGFloat(radius), startAngle:totalAngle, endAngle: CGFloat(thisAngle)+totalAngle, clockwise:true)
            totalAngle+=CGFloat(thisAngle)
            myBezier.closePath()
            
            let layer = CAShapeLayer()
            layer.path = myBezier.CGPath
            var thisColor = getColor(colors[i])
            layer.fillColor = thisColor.CGColor
            if(percentages.count != 1){
                layer.strokeColor = UIColor.whiteColor().CGColor
            }else{
                layer.strokeColor = UIColor.grayColor().CGColor
            }
            self.layer.addSublayer(layer)
            
        }
        
    }
    
    
    func addKey(){
        var corner = CGPoint(x: calculateNewX(5/4*M_PI)+15, y: calculateNewY(3/2*M_PI)+10)
        
        
        for(var i = 0;i<names.count;i++){
            var thisY = 25.0*Double(i)
            if(i>3){
                thisY = thisY-(25*4)
            }
            var thisX = 0
            if(i>3){
                thisX = thisX+140
            }
            let context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 20.0)
            CGContextMoveToPoint(context, corner.x+CGFloat(thisX),corner.y+CGFloat(thisY))
            var thisColor = getColor(colors[i])
            
            CGContextSetStrokeColorWithColor(context, thisColor.CGColor)
            CGContextAddLineToPoint(context,corner.x+CGFloat(thisX),corner.y+CGFloat(thisY+20))
            CGContextStrokePath(context)
            
            var label = UILabel(frame: CGRectMake(corner.x+20+CGFloat(thisX),corner.y+CGFloat(thisY), 110, 21))
            
            label.textAlignment = NSTextAlignment.Left
            label.text = names[i]
            label.font = label.font.fontWithSize(15)
            label.textColor = c.primaryD
            self.addSubview(label)
        }
        
    }
    func calculateNewX(angle:Double)->CGFloat{
        var ratio = cos(angle)
        return CGFloat(centerX+(ratio*radius))
        
    }
    func calculateNewY(angle:Double)->CGFloat{
        var ratio = sin(angle)
        return CGFloat(centerY-(ratio*radius))
        
    }
    func getColor(a:Int)->UIColor{
        
            return colorScheme[a]
            
    
        
    }
}
