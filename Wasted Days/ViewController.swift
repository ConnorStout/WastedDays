//
//  ViewController.swift
//  Wasted Days
//
//  Created by Connor Stout on 7/4/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var currYearMonthDay:Int = 0
    var currIndex:Int = 0
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dailyTimeTable: UITableView!
    
    override func viewDidLoad() {
        if(currYearMonthDay == 0){
            currYearMonthDay = getCurrYearMonthDay()
            possiblyAddNewDay()
        }
        
        super.viewDidLoad()
        print(currYearMonthDay)
        
        self.view.backgroundColor = UIColor.brownColor()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
    override func viewDidAppear(animated: Bool) {
        let backgroundImage = UIImage(named: "blackbackground.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.dailyTimeTable.backgroundView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeCell
        //time label
        cell.backgroundColor = .clearColor()
        
        var currTime = indexPath.row
        var labelString:String = ""
        if(currTime==0){
            labelString = "12:00 AM"
            
        }else if (currTime<12){
            labelString = "\(currTime):00"
            currTime+=1
        }else if (currTime == 12){
            labelString = "12:00 PM"
        }
        else{
            labelString = "\(currTime-12):00"
        }
       
        
        cell.timeLabel.text = labelString
        
        //task and cat
        cell.nameOfEvent.text = appDelegate.allDays[currIndex].tasks[indexPath.row]
        let color:Int = appDelegate.allDays[currIndex].types[indexPath.row]
        if(color==0){
            cell.colorDez.backgroundColor? = UIColor.blueColor()
            
        }else{
            
             cell.colorDez.backgroundColor? = UIColor.blackColor()
        }
        
        
        return cell
        
        
    }
 
    func doesDayExist()->Int{
     
        for(var i=0;i<appDelegate.allDays.count;i++){
            if(appDelegate.allDays[i].yearMonthDay==self.currYearMonthDay){
                return i;
                
            }
            
            
        }
        return -1
        
    }
    func getCurrYearMonthDay()->Int{
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        print(year)
        print(month)
        print(day)
        var dayString:String
        var monthString:String
        if(day<10){
            dayString = ("0"+String(day))
            
        }else{
            dayString = String(day)
        }
        if(month<10){
            monthString = ("0"+String(month))
            
        }else{
            monthString = String(month)
        }
        return Int((String(year)+monthString+dayString))!
    }
    func getDayIndex(){
        
        
    }
    

    @IBAction func leftButton(sender: AnyObject) {
        currYearMonthDay-=1;
        possiblyAddNewDay()
        
        dailyTimeTable.reloadData()
        
    }
    
    
    @IBAction func rightButton(sender: AnyObject) {
        
    }
    func possiblyAddNewDay(){
        if(doesDayExist()==(-1)){
            var newDay:Day = Day(yearMonthDay:currYearMonthDay);
            appDelegate.allDays.append(newDay)
            currIndex = appDelegate.allDays.count-1
        }else{
            currIndex = doesDayExist()
        }
        updateLabel()
    }
    func updateLabel(){
        var labelString:String = ("\(appDelegate.allDays[currIndex].month)/\(appDelegate.allDays[currIndex].day)/\(appDelegate.allDays[currIndex].year)")
        dateLabel.text = labelString
        
    }
}

