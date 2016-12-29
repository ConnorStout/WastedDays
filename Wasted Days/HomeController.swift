//
//  HomeController.swift
//  Wasted Days
//
//  Created by Connor Stout on 8/30/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import Foundation
import UIKit
import Charts
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
    let dateFormatter = Foundation.DateFormatter()
    @IBOutlet var pieView: UIView!
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
   
    override func viewDidLoad(){
        print("got into home")
        super.viewDidLoad()
        self.view.backgroundColor = c.primary
     
        let date = Date()
        today = df.getCurrYearMonthDay()
       // lineChartView.noDataText = "You need to provide data for the chart."
       // lineChartView.backgroundColor = UIColor.black
        _ = df.possiblyAddNewDay(today)
        print("today here is\(today)")
        // US English Locale (en_US)
        dateFormatter.dateFormat = "EEEE MMMM dd, yyyy"
       
        homeLabel.text = dateFormatter.string(from: date)
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(axis: ["a","b", "c", "d", "e","f","g"], values: getBarChartValues())
        print(getBarChartValues())
        
      // Do any additional setup after loading the view, typically from a nib.
    }
 
    
    func setChart(axis: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
    
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
   

        
        let lineChartDataSet = BarChartDataSet(values: dataEntries, label: "Sleep")
        lineChartDataSet.colors = [c.secondary]
        
        
        let lineChartData = BarChartData(dataSet: lineChartDataSet)
        
        barChartView.data = lineChartData
        let formatter = MyAxisFormatter(axis: axis)
        barChartView.xAxis.valueFormatter = formatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.drawGridBackgroundEnabled = true
        barChartView.gridBackgroundColor = NSUIColor.lightGray
        barChartView.chartDescription?.text = ""
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 10
        barChartView.rightAxis.axisMinimum = 0
        barChartView.rightAxis.axisMaximum = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        chart.removeFromSuperview()
        getPieChartValues(chartState)
        chart = PieChart(frame: self.view.frame,percentage: percentages,names: names,color: colors)
        self.pieView.addSubview(chart)
        setChart(axis: getBarChartLabels(), values: getBarChartValues())
        chart.isUserInteractionEnabled = false
     

      
        
    
    }
    func getBarChartValues()->[Double]{
        var result:[Double] = []
        var thisDay = today
        var indexToday = df.getDayIndex(today)
        for i in 0..<7 {
            var thisAmount = 0
            if(indexToday == -1){
                
            }else{
                for j in 0..<24{
        
                
                    var thisType = appDel.allDays[indexToday].types[j]
                    if(thisType==0){
                        thisAmount+=1
                    }
                
                }
            }
            result.append(Double(thisAmount))
            thisDay = df.previousDay(thisDay)
            indexToday = df.getDayIndex(thisDay)
        }
        print(result)
        return result.reversed()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getBarChartLabels()->[String]{
        var result:[String] = []
        for i in 0..<7{
            if(i == 0){
                result.append("Today")
            }else{
                let thisFormatter = Foundation.DateFormatter()
                thisFormatter.dateFormat = "EEEE"
                let yesterday = NSCalendar.current.date(byAdding: .day, value: 0-i, to: Date())
           
            
                result.append(thisFormatter.string(from: yesterday!))
            }
        
        }
        return result.reversed()
        
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
