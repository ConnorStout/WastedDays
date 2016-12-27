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
        let c = ColorObject()
        colorScheme = c.pieArray()
        if(color.count>0){
            hasKey = true
            percentages = percentage
            self.names = names
            self.colors = color
        }
        radius = Double(self.frame.size.width/4)
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.frame.width*(4/6))
        centerY = Double(radius+10)
        chartCenter = CGPoint(x: CGFloat(centerX), y: CGFloat(centerY))
        self.frame.size.height = (self.frame.size.height/3)
 
    }
    init(frame: CGRect, percentage:[Double], color:[Int]) {
        let c = ColorObject()
        colorScheme = c.pieArray()
        hasKey = true
        super.init(frame: frame)
        percentages = percentage
        radius = Double(self.frame.size.width/4)
        self.colors = color
        self.backgroundColor = UIColor(white: 1, alpha: 0.5)
        centerX = Double(self.center.x)
        centerY = Double(radius+10)
        chartCenter = CGPoint(x: CGFloat(centerX), y: CGFloat(centerY))
        self.frame.size.height = (self.frame.size.height/3)
        
    }
    init() {
    
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        drawLines()
        if(hasKey){
            addKey()
        }
        
    }
    
    func drawLines() {
        var totalAngle:CGFloat = 0
        
        for i in 0 ..< percentages.count {
            
            let thisAngle = percentages[i]*2*M_PI
            let myBezier = UIBezierPath()
           
            myBezier.move(to: chartCenter)
            myBezier.addArc(withCenter: chartCenter, radius:CGFloat(radius), startAngle:totalAngle, endAngle: CGFloat(thisAngle)+totalAngle, clockwise:true)
            totalAngle+=CGFloat(thisAngle)
            myBezier.close()
            
            let layer = CAShapeLayer()
            
            layer.path = myBezier.cgPath
          
            let thisColor = getColor(colors[i])
            layer.fillColor = thisColor.cgColor
            if(percentages.count != 1){
                layer.strokeColor = UIColor.white.cgColor
            }else{
                layer.strokeColor = UIColor.gray.cgColor
            }
            self.layer.addSublayer(layer)
            
        }
        
    }
    
    
    func addKey(){
        let corner = CGPoint(x: frame.origin.x+40, y: frame.origin.y+20)
        
        
        for i in 0 ..< names.count {
            let thisY = 25.0*Double(i)
       
            let thisX = 0
         
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(20.0)
            context?.move(to: CGPoint(x: corner.x+CGFloat(thisX), y: corner.y+CGFloat(thisY)))
            let thisColor = getColor(colors[i])
            
            context?.setStrokeColor(thisColor.cgColor)
            context?.addLine(to: CGPoint(x: corner.x+CGFloat(thisX), y: corner.y+CGFloat(thisY+20)))
            context?.strokePath()
            
            let label = UILabel(frame: CGRect(x: corner.x+20+CGFloat(thisX),y: corner.y+CGFloat(thisY), width: 110, height: 21))
            
            label.textAlignment = NSTextAlignment.left
            label.text = names[i]
            label.font = label.font.withSize(15)
            label.textColor = c.primaryD
            self.addSubview(label)
        }
        
    }
    func calculateNewX(_ angle:Double)->CGFloat{
        let ratio = cos(angle)
        return CGFloat(centerX+(ratio*radius))
        
    }
    func calculateNewY(_ angle:Double)->CGFloat{
        let ratio = sin(angle)
        return CGFloat(centerY-(ratio*radius))
        
    }
    func getColor(_ a:Int)->UIColor{
        
            return colorScheme[a]
            
    
        
    }
}
