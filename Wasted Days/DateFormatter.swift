//
//  DateFormatter.swift
//  Wasted Days
//
//  Created by Connor Stout on 9/6/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

class DateFormatter {
    
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
    
 
    
}
