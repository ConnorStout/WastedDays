//
//  HomeController.swift
//  Wasted Days
//
//  Created by Connor Stout on 8/30/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import Foundation
import UIKit

class HomeController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var percentages:[Double] = []
    let c = ColorObject()
    let df = DateFormatter()
    var names:[String] = []
    var colors:[Int] = []
    var colorsCount:[Int] = []
    var chart = PieChart()
    var chartState = 1
    var today = 0
   
    @IBOutlet var pieView: UIView!
    @IBOutlet var homeLabel: UILabel!
   
    override func viewDidLoad(){
        print("got into home")
        super.viewDidLoad()
        self.view.backgroundColor = c.primary
        let dateFormatter = Foundation.DateFormatter()
        let date = Date()
        today = df.getCurrYearMonthDay()
        df.possiblyAddNewDay(today)
        print("today here is\(today)")
        // US English Locale (en_US)
        dateFormatter.dateFormat = "EEEE MMMM dd, yyyy"

        homeLabel.text = dateFormatter.string(from: date)
     
      

       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        chart.removeFromSuperview()
        getPieChartValues(chartState)
        chart = PieChart(frame: self.view.frame,percentage: percentages,names: names,color: colors)
        self.pieView.addSubview(chart)
 
        chart.isUserInteractionEnabled = false
     

      
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPieChartValues(_ howManyDays:Int){
        names.removeAll()
        percentages.removeAll()
        colors.removeAll()
        colorsCount.removeAll()
        var numberOfDays = 0
       
            print("got here")
            print(today)
            df.possiblyAddNewDay(today)
            print("howManyDays\(howManyDays)")
        for j in 0..<howManyDays {
                    let thisDayIndex = df.getIndexOfRelativeDay(today, daysBack: j, forward: false)
                    print(thisDayIndex)
            for i in 0 ..< 24 {
                    
                    if(thisDayIndex == -1){
                        
                    }else{
                 
                    let thisTask = appDel.allDays[thisDayIndex].types[i]
                    numberOfDays += 1
                    if(colors.contains(thisTask)){
                        colorsCount[colors.index(of: thisTask)!]+=1 //= colorsCount[names.indexOf(thisTask)!]+1
                        
                    }else{
                        colors.append(thisTask)
                        colorsCount.append(1)
                        names.append(getNameFromColor(thisTask))
                    }
                    }
                
                }
                print(numberOfDays)
            }
        
        
        setPercentage(Double(numberOfDays))
        print("fff\(numberOfDays)")
    }
    func setPercentage(_ number:Double){
        for i in 0..<colorsCount.count {
            percentages.append(Double(colorsCount[i])/(number))
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return pieView.frame.size.height/6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currIndex = df.getDayIndex(today)
        return appDel.allDays[currIndex].goals.count
    }
    
    
    
    
    
    
    
    
    
    func getNameFromColor(_ a:Int)->String{
        
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
    
    
    @IBAction func changeChart(_ sender: UIButton) {
        let newValue = sender.tag
        if(chartState != newValue){
            chartState = newValue
            chart.removeFromSuperview()
            getPieChartValues(chartState)
            chart = PieChart(frame: self.view.frame,percentage: percentages,names: names,color: colors)
            self.pieView.addSubview(chart)
            chart.isUserInteractionEnabled = false
        }
        print("her")
        
    }
    
}
