//
//  ChangeTypeView.swift
//  Wasted Days
//
//  Created by Connor Stout on 9/1/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ChangeTypeView: UIView, UIGestureRecognizerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var nameArray:[String] = ["sleep", "study","workout", "personal development", "work", "eat","relax/social", "waste"]
    var midLocation:CGPoint = CGPoint(x: 0, y: 0)
    var superFrame:CGRect = CGRectMake(0, 0, 0, 0)
    var sentView:UIView = UIView()
    var currIndex:Int = 0
   
    init(frame:CGRect,sender:UIView, currIndex:Int) {
      
        var newFrame = frame
        newFrame.size.width = frame.size.width/2
        newFrame.size.height = frame.size.height/2
        sentView = sender
        self.currIndex = currIndex
        super.init(frame: newFrame)
        superFrame = frame
        var midY = frame.height / 2
        var midX = frame.width / 2
        midLocation = CGPoint(x: midX, y: midY)
        self.center = CGPoint(x: midX, y: midY+frame.height)
        self.backgroundColor = UIColor.whiteColor()
     
        //sender.backgroundColor = UIColor.redColor()'
        animateEntrance()
   
        
    }
    init() {
        super.init(frame:CGRectMake(0, 0, 0, 0))
        
    }
    override func drawRect(rect: CGRect) {

        for(var i = 0;i<nameArray.count;i++){
            var label = UILabel(frame: CGRectMake(self.center.x,CGFloat(0+10*i), self.frame.width,self.frame.height/CGFloat(nameArray.count)))
            label.center = CGPointMake(self.frame.size.width  / 2,
                CGFloat(label.frame.size.height/2.0+CGFloat(label.frame.size.height*CGFloat(i))));
            label.textAlignment = NSTextAlignment.Center
            label.font = label.font.fontWithSize(15)
            label.textColor = UIColor.whiteColor()
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            label.addGestureRecognizer(tap)
            tap.delegate = self
            
            var a = nameArray[i]
            var c = ColorObject()
            
            label.backgroundColor=c.pieArray()[i]
            label.text = a;
            
            label.userInteractionEnabled = true
            label.tag = i
            self.addSubview(label)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animateEntrance(){
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            
            
    
            self.center = self.midLocation
            }, completion: { finished in
                
        })
        
        
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        
        var a = nameArray[(sender?.view!.tag)!]
        print("sender:\(sender?.view!.tag)")
        appDelegate.allDays[currIndex].types[Int((sentView.tag))] = (sender?.view!.tag)!
        
        var i = getNameNumber(a)
        var c = ColorObject()
        sentView.backgroundColor = c.pieArray()[i]
            
            
        
        
        
     
        animateExit()
        
        
        
        
    }
    func getNameNumber(input:String)->Int{
        var i=0;
        for x in nameArray{
            
            if(x==input){
                return i
                
            }
            i+=1
        }
        return 7;
        
    }
    
    func animateExit(){
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            
            
            self.center = CGPoint(x: self.midLocation.x,y: self.midLocation.y-self.superFrame.height)
            }, completion: { finished in
                
                self.removeFromSuperview()
                print(self.appDelegate.allDays[self.currIndex].types)
        })
        
    }
}