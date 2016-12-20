//
//  ColorObject.swift
//  Wasted Days
//
//  Created by Connor Stout on 10/20/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//
import UIKit
import Foundation

class ColorObject {
    var primary:UIColor = UIColor(red: 29/255, green: 219/255, blue: 255/255, alpha: 1.0)
    var primaryN:UIColor = UIColor(red: 0, green: 185/255, blue: 220/255, alpha: 1.0)
    var primaryD:UIColor = UIColor(red: 0, green: 60/255, blue: 90/255, alpha: 1.0)
    var primaryL:UIColor = UIColor(red: 136/255, green: 236/255, blue: 255/255, alpha: 1.0)
    var primaryLi:UIColor = UIColor(red: 192/255, green: 245/255, blue: 255/255, alpha: 1.0)
    
    var secondary:UIColor = UIColor(red: 50/255, green: 98/255, blue: 255/255, alpha: 1.0)
    var secondaryN:UIColor = UIColor(red:0, green: 30/255, blue: 127/255,alpha: 1.0)
    var secondaryD:UIColor = UIColor(red:197/255, green: 211/255, blue: 255/255,alpha: 1.0)
    var secondaryL:UIColor = UIColor(red:147/255, green: 172/255, blue: 255/255,alpha: 1.0)
    var secondaryLi:UIColor = UIColor(red:197, green: 211, blue: 255,alpha: 1.0)
    
    var secondary2:UIColor = UIColor(red: 255/255, green: 183/255, blue: 24/255, alpha: 1.0)
    var secondary2N:UIColor = UIColor(red:240/255, green: 165/255, blue: 0,alpha: 1.0)
    var secondary2D:UIColor = UIColor(red:187/255, green: 129/255, blue: 0,alpha: 1.0)
    var secondary2L:UIColor = UIColor(red:255/255, green: 217/255, blue: 133/255,alpha: 1.0)
    var secondary2Li:UIColor = UIColor(red:255, green: 235, blue: 190,alpha: 1.0)
    
    var opp:UIColor = UIColor(red: 255/255, green: 137/255, blue: 24/255, alpha: 1.0)
    var oppN:UIColor = UIColor(red:240/255, green: 117/255, blue: 0,alpha: 1.0)
    var oppD:UIColor = UIColor(red:187/255, green: 91/255, blue: 0,alpha: 1.0)
    var oppL:UIColor = UIColor(red:255/255, green: 193/255, blue: 133/255,alpha: 1.0)
    var oppLi:UIColor = UIColor(red:255/255, green: 222/255, blue: 190/255,alpha: 1.0)
    
    
    
    func pieArray()->[UIColor]{
        let returnColors:[UIColor]=[secondary,secondaryN,secondary2N, primaryLi, secondary2L, secondaryL, secondaryD, UIColor.grayColor()]
        
        return returnColors
    }
    func getNumber(input: UIColor)->Int{
        var inc = 0;
        for x in self.pieArray(){
            
            if(input==x){
                
                return inc
            }
            inc+=1
            
        }
        
        return 7;
        
    }
    
}
