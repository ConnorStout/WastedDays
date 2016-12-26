//
//  HomeController.swift
//  Wasted Days
//
//  Created by Connor Stout on 8/30/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import Foundation
import UIKit

class HomeController : ViewController {
    let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var percentages:[Double] = []
    
    var names:[String] = []
    var colors:[Int] = []
    var colorsCount:[Int] = []
    var chart = PieChart()
    var chartState = 10
    @IBOutlet var pieView: UIView!
    @IBOutlet var homeLabel: UILabel!
   
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = c.primary
        
        let dateFormatter = NSDateFormatter()
    
        
        let date = NSDate()

        // US English Locale (en_US)
        dateFormatter.dateFormat = "MMMM dd yyyy"

        homeLabel.text = dateFormatter.stringFromDate(date)
     
      

       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        chart.removeFromSuperview()
        getPieChartValues(chartState)
        chart = PieChart(frame: self.view.frame,percentage: percentages,names: names,color: colors)
        self.pieView.addSubview(chart)
        chart.userInteractionEnabled = false
     

      
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPieChartValues(howManyDays:Int){
        names.removeAll()
        percentages.removeAll()
        colors.removeAll()
        colorsCount.removeAll()
        var numberOfDays = 0
       
            print("got here")
            var day = getCurrYearMonthDay()
            possiblyAddNewDay()
            
            for(var j = 0;j<howManyDays;j++){
                for(var i = 0;i<24;i++){
                    if(currIndex-j<0){
                        
                    }else{
                    var thisTask = appDelegate.allDays[currIndex-j].types[i]
                    numberOfDays++
                    if(colors.contains(thisTask)){
                        colorsCount[colors.indexOf(thisTask)!]+=1 //= colorsCount[names.indexOf(thisTask)!]+1
                        
                    }else{
                        colors.append(thisTask)
                        colorsCount.append(1)
                        names.append(getNameFromColor(thisTask))
                    }
                    }
                
                }
            }
        
        
        setPercentage(Double(numberOfDays))
        print("fff\(numberOfDays)")
    }
    func setPercentage(number:Double){
        for(var i = 0;i<colorsCount.count;i++){
            percentages.append(Double(colorsCount[i])/(number))
            
        }
        
        
    }
    func getNameFromColor(a:Int)->String{
        
        if(a==0){
            return "sleep"
            
        }else if(a==1){
            return "study"
            
        }else if(a==2){
            return "workout"
            
        }else if(a==3){
            return "personal dev."
            
        }else if(a==4){
            return "work"
            
        }else if(a==5){
            return  "eat"
            
        }else if(a==6){
            return  "relax/social"
            
        }else if(a==7){
            return  "waste"
            
        }else{
            
            return "waste"
        }
        
    }
    
    
    @IBAction func changeChart(sender: UIButton) {
        var newValue = sender.tag
        if(chartState != newValue){
            chartState = newValue
            chart.removeFromSuperview()
            getPieChartValues(chartState)
            chart = PieChart(frame: self.view.frame,percentage: percentages,names: names,color: colors)
            self.pieView.addSubview(chart)
            chart.userInteractionEnabled = false
        }
        print("her")
        
    }
    
}