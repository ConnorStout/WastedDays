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
    
    
    init(frame: CGRect, percentage:[Double],names:[String], color:[Int]) {
        super.init(frame: frame)
        if(color.count>0){
            hasKey = true
            percentages = percentage
            self.names = names
            self.colors = color
        }
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
    init() {
    
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        
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
            var thisColor = getColor(colors[i])
            layer.fillColor = thisColor.CGColor
            layer.strokeColor = UIColor.whiteColor().CGColor
            self.layer.addSublayer(layer)
            
        }
        
    }
    
    
    func addKey(){
        var corner = CGPoint(x: calculateNewX(5/4*M_PI)+15, y: calculateNewY(3/2*M_PI)+10)
        
        
        for(var i = 0;i<names.count;i++){
            var thisY = 30.0*Double(i)
            if(i>3){
                thisY = thisY-(30*4)
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
        if(a==0){
            return UIColor.purpleColor()
            
        }else if(a==1){
            return UIColor.greenColor()
            
        }else if(a==2){
            return UIColor.init(red: 105/255, green: 155/255, blue: 0, alpha: 1)
            
        }else if(a==3){
            return UIColor.orangeColor()
            
        }else if(a==4){
            return UIColor.redColor()
            
        }else if(a==5){
            return  UIColor.blueColor()
            
        }else if(a==6){
            return  UIColor.grayColor()
            
        }else if(a==7){
            return  UIColor.lightGrayColor()
            
        }else{
            
            return UIColor.blackColor()
        }
        
    }}
