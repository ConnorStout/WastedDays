//
//  ChangeTypeView.swift
//  Wasted Days
//
//  Created by Connor Stout on 9/1/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ChangeTypeView: UIView, UIGestureRecognizerDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var nameArray:[String] = ["sleep", "study","workout", "personal development", "work", "eat","relax/social", "waste"]
    var midLocation:CGPoint = CGPoint(x: 0, y: 0)
    var superFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
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
        let midY = frame.height / 2
        let midX = frame.width / 2
        midLocation = CGPoint(x: midX, y: midY)
        self.center = CGPoint(x: midX, y: midY+frame.height)
        self.backgroundColor = UIColor.white
     
        //sender.backgroundColor = UIColor.redColor()'
        animateEntrance()
   
        
    }
    init() {
        super.init(frame:CGRect(x: 0, y: 0, width: 0, height: 0))
        
    }
    override func draw(_ rect: CGRect) {

        for i in 0 ..< nameArray.count {
            let label = UILabel(frame: CGRect(x: self.center.x,y: CGFloat(0+10*i), width: self.frame.width,height: self.frame.height/CGFloat(nameArray.count)))
            label.center = CGPoint(x: self.frame.size.width  / 2,
                y: CGFloat(label.frame.size.height/2.0+CGFloat(label.frame.size.height*CGFloat(i))));
            label.textAlignment = NSTextAlignment.center
            label.font = label.font.withSize(15)
            label.textColor = UIColor.white
            let tap = UITapGestureRecognizer(target: self, action: #selector(ChangeTypeView.handleTap(_:)))
            label.addGestureRecognizer(tap)
            tap.delegate = self
            
            let a = nameArray[i]
            let c = ColorObject()
            
            label.backgroundColor=c.pieArray()[i]
            label.text = a;
            
            label.isUserInteractionEnabled = true
            label.tag = i
            self.addSubview(label)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animateEntrance(){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            
    
            self.center = self.midLocation
            }, completion: { finished in
                
        })
        
        
    }
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let a = nameArray[(sender?.view!.tag)!]
        print("sender:\(sender?.view!.tag)")
        appDelegate.allDays[currIndex].types[Int((sentView.tag))] = (sender?.view!.tag)!
        
        let i = getNameNumber(a)
        let c = ColorObject()
        sentView.backgroundColor = c.pieArray()[i]
            
            
        
        
        
     
        animateExit()
        
        
        
        
    }
    func getNameNumber(_ input:String)->Int{
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
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            
            self.center = CGPoint(x: self.midLocation.x,y: self.midLocation.y-self.superFrame.height)
            }, completion: { finished in
                
                self.removeFromSuperview()
                print(self.appDelegate.allDays[self.currIndex].types)
        })
        
    }
}
