//
//  ViewController.swift
//  Wasted Days
//
//  Created by Connor Stout on 7/4/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var currYearMonthDay:Int = 0
    var currIndex:Int = 0
    var changeViewOut = false
    var currChangeType: ChangeTypeView = ChangeTypeView()
    var dateFormatter:DateFormatter = DateFormatter()
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dailyTimeTable: UITableView!
    
    override func viewDidLoad() {
        if(currYearMonthDay == 0){
            appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            currYearMonthDay = getCurrYearMonthDay()
            possiblyAddNewDay()
            print(appDelegate.allDays[currIndex].types)
            
        }
        
        super.viewDidLoad()
      
        
        
        // Do any additional setup after loading the view, typically from a nib.
       
        let backgroundImage = UIImage(named: "blackbackground.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.dailyTimeTable?.backgroundView = imageView
    }
    override func viewDidAppear(animated: Bool) {
        
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
        cell.backgroundView = UIImageView(image: UIImage(named: "celldesign.jpg"))
        cell.selectionStyle = UITableViewCellSelectionStyle.None
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
        
        //task
        cell.nameOfEvent.text = appDelegate.allDays[currIndex].tasks[indexPath.row]
        
        cell.nameOfEvent.delegate = self
        cell.nameOfEvent.tag = indexPath.row
     
        
        
        //cat
        let color:Int = appDelegate.allDays[currIndex].types[indexPath.row]
    
        cell.colorDez.backgroundColor? = getColor(color)
        cell.colorDez.tag = indexPath.row
        
        
        var pressed = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        
        cell.colorDez.addGestureRecognizer(pressed)
        cell.colorDez.userInteractionEnabled = true
        
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
        currYearMonthDay = dateFormatter.previousDay(currYearMonthDay);
        possiblyAddNewDay()
       
        dailyTimeTable.reloadData()
        print(appDelegate.allDays[currIndex].types)
    }
    
    
    @IBAction func rightButton(sender: AnyObject) {
        currYearMonthDay = dateFormatter.nextDay(currYearMonthDay)
        possiblyAddNewDay()
 
        dailyTimeTable.reloadData()
        
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
        

        dateLabel?.text = labelString
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        appDelegate.allDays[currIndex].tasks[Int(textField.tag)] = textField.text!
    }
    @IBAction func longPressed(sender: UILongPressGestureRecognizer)
    {

        
        if(!self.view.subviews.contains(currChangeType)){
            var newChangeView = (ChangeTypeView(frame: self.view.frame,sender: sender.view!,currIndex:currIndex))
            
            currChangeType = newChangeView
            view.addSubview(newChangeView)
           
            changeViewOut = true
            
        }
        
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
        
    }
    
    func getNumberFromColor(a:UIColor)->Int{
        
        if(a==UIColor.purpleColor()){
            return 0
            
        }else if(a==UIColor.greenColor()){
            return 1
            
        }else if(a==UIColor.init(red: 105/255, green: 155/255, blue: 0, alpha: 1)){
            return 2
            
        }else if(a==UIColor.orangeColor()){
            return 3
            
        }else if(a==UIColor.redColor()){
            return 4
            
        }else if(a==UIColor.blueColor()){
            return 5
            
        }else if(a==UIColor.grayColor()){
            return 6
            
        }else if(a==UIColor.lightGrayColor()){
            return 7
            
        }else{
            return 7
        }
    }

    
}

