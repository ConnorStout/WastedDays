//
//  PieTouchView.swift
//  PiChart
//
//  Created by Connor Stout on 8/31/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class PieTouchView: UIView {
    var centerX:Double = 0
    var centerY:Double = 0
    var radius:Double = 0
    var percentages:[Double] = []
    var names:[String] = []
    var colors:[Int] = []
    var hasKey = false
    
    
    init(frame: CGRect, percentage:[Double],names:[String], color:[Int]) {
        hasKey = true
        super.init(frame: frame)
        percentages = percentage
        self.names = names
        self.colors = color
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.center.x)
        centerY = Double(self.center.y)
        
        
        
    }
    init(frame: CGRect, percentage:[Double], color:[Int]) {
        hasKey = true
        super.init(frame: frame)
        percentages = percentage
        
        self.colors = color
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.center.x)
        centerY = Double(self.center.y)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        radius = Double(self.frame.size.width/2-10)
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
            myBezier.moveToPoint(CGPointMake(center.x, center.y))
            myBezier.addArcWithCenter(center, radius:CGFloat(radius), startAngle:totalAngle, endAngle: CGFloat(thisAngle)+totalAngle, clockwise:true)
            totalAngle+=CGFloat(thisAngle)
            myBezier.closePath()
            
            let layer = CAShapeLayer()
            layer.path = myBezier.CGPath
            layer.fillColor = getColor(colors[i])
            layer.strokeColor = UIColor.whiteColor().CGColor
            self.layer.addSublayer(layer)
            
        }
        
    }
    
    
    func addKey(){
        var corner = CGPoint(x: calculateNewX(5/4*M_PI)+5, y: calculateNewY(3/2*M_PI)+10)
        
        
        for(var i = 0;i<names.count;i++){
            let context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 20.0)
            CGContextMoveToPoint(context, corner.x,corner.y+CGFloat(30.0*Double(i)))
            CGContextSetStrokeColorWithColor(context, getColor(colors[i]))
            CGContextAddLineToPoint(context,corner.x,corner.y+CGFloat(30.0*Double(i))+20)
            CGContextStrokePath(context)
            
            var label = UILabel(frame: CGRectMake(corner.x+20,corner.y+CGFloat(30.0*Double(i)), 100, 21))
            
            label.textAlignment = NSTextAlignment.Left
            label.text = names[i]
            label.font = label.font.fontWithSize(15)
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
    func getColor(type:Int)->CGColor{
        if(type==0){
            return UIColor.blueColor().CGColor
        }else if(type==1){
            return UIColor.redColor().CGColor
            
        }else if(type==2){
            return UIColor.yellowColor().CGColor
        }else if(type==3){
            return UIColor.greenColor().CGColor
        }else{
            return UIColor.blackColor().CGColor
        }
        
        
    }
}
