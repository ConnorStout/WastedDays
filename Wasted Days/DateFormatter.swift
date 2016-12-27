//
//  DateFormatter.swift
//  Wasted Days
//
//  Created by Connor Stout on 9/6/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//
import Foundation
import UIKit

class DateFormatter {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    func nextDay(var yearMonthDay:Int)->Int{
        
        let stringDate = String(yearMonthDay)
        var splitString = Array(stringDate.characters)
        //2016.08.26
        var yearStr = ("\(splitString[0])\(splitString[1])")
        yearStr += ("\(splitString[2])\(splitString[3])")
        var year = Int(yearStr)!
        var month = Int("\(splitString[4])\(splitString[5])")!
        var day = Int("\(splitString[6])\(splitString[7])")!
        
        var isLeap = isYearLeapYear(year)
        print("ISLEAP\(isLeap)")
        
        //20161225
        if(month==1||month==3||month==5||month==7||month==8||month==10){
            if(day<31){
                return yearMonthDay+1;
                
                
            }else{
                yearMonthDay = yearMonthDay+100
                yearMonthDay = yearMonthDay-30
                return yearMonthDay
            }
            
        }else if(month==4||month==6||month==9||month==11){
            if(day<30){
                return yearMonthDay+1;
                
                
            }else{
                
                yearMonthDay+=100
                yearMonthDay = yearMonthDay-29
                return yearMonthDay
            }
            
        }else if(month==2){
            if(isYearLeapYear(year)){
                if(day<29){
                    return yearMonthDay+1
                    
                }else{
                    yearMonthDay = yearMonthDay+100
                    return yearMonthDay-28
                    
                    
                }
  
            }else{
                if(day<28){
                    return yearMonthDay+1
                    
                }else{
                    yearMonthDay = yearMonthDay+100
                    return yearMonthDay-27
                    
                    
                }
            }
            
        }else{
            if(day<31){
                return yearMonthDay+1
                
            }else{
                yearMonthDay = yearMonthDay-1100
                yearMonthDay = yearMonthDay-30
                return yearMonthDay+10000
                
                
            }
        }
        
       
        
    }
    func previousDay(var yearMonthDay:Int)->Int{
        let stringDate = String(yearMonthDay)
        var splitString = Array(stringDate.characters)
        //2016.08.26
        var yearStr = ("\(splitString[0])\(splitString[1])")
        yearStr += ("\(splitString[2])\(splitString[3])")
        var year = Int(yearStr)!
        var month = Int("\(splitString[4])\(splitString[5])")!
        var day = Int("\(splitString[6])\(splitString[7])")!
        
        var isLeap = isYearLeapYear(year)
        print("ISLEAP\(isLeap)")
        
        //20161225
        if(month==2||month==4||month==6||month==8||month==9||month==11){
            if(day>1){
                return yearMonthDay-1;
                
                
            }else{
                yearMonthDay = yearMonthDay-100
                yearMonthDay = yearMonthDay+30
                return yearMonthDay
            }
            
        }else if(month==5||month==7||month==10||month==12){
            if(day>1){
                return yearMonthDay-1;
                
                
            }else{
                
                yearMonthDay-=100
                yearMonthDay = yearMonthDay+29
                return yearMonthDay
            }
            
        }else if(month==3){
            if(day>1){
                return yearMonthDay-1
            }else if(isYearLeapYear(year)){
                yearMonthDay = yearMonthDay-100
                return yearMonthDay+28
            }else{
                yearMonthDay = yearMonthDay-100
                return yearMonthDay+27
            }

        }else{
            if(day>1){
                return yearMonthDay-1
                
            }else{
                yearMonthDay = yearMonthDay+1100
                yearMonthDay = yearMonthDay+30
                return yearMonthDay-10000
                
                
            }
        }
        
        
    }
    
    func isYearLeapYear(year:Int)->Bool {
        
        return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0;
    }
    func possiblyAddNewDay(yearMonthDay:Int)->Int{
        if(!doesDayExist(yearMonthDay)){
            var newDay:Day = Day(yearMonthDay:yearMonthDay);
            self.appDelegate.allDays.append(newDay)
            return appDelegate.allDays.count-1
        }else{
            return getDayIndex(yearMonthDay)
        }
    }
    func doesDayExist(yearMonthDay:Int)->Bool{
        
        for(var i=0;i<appDelegate.allDays.count;i++){
            if(appDelegate.allDays[i].yearMonthDay==yearMonthDay){
                return true;
                
            }
            
            
        }
        return false
        
    }
    func getDayIndex(yearMonthDay:Int)->Int{
        
        for(var i=0;i<appDelegate.allDays.count;i++){
            if(appDelegate.allDays[i].yearMonthDay==yearMonthDay){
                return i;
                
            }
            
            
        }
        return -1
        
    }
    func getIndexOfRelativeDay(currDay: Int, daysBack:Int, forward:Bool)-> Int{
        if(forward){
            var newDay = currDay
            for(var i = 0; i<daysBack; i++){
                newDay = nextDay(currDay)
                
            }
            return getDayIndex(newDay)
            
        }else{
            var newDay = currDay
            for(var i = 0; i<daysBack; i++){
                newDay = previousDay(newDay)
                
            }
            print(newDay)
            return getDayIndex(newDay)
        }
        
        
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
    
    
 
    
}
