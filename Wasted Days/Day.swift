//
//  Day.swift
//  Wasted Days
//
//  Created by Connor Stout on 8/22/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

class Day{
    
    var year:Int
    var month:Int
    var day:Int
    var tasks:[String]
    var types:[String]
    var yearMonthDay:Int
    init(year:Int, month:Int, day:Int){
        self.year = year
        self.month = month
        tasks = []
        types = []
        for(var i = 0; i<24;i++){
            tasks[i] = ""
            types[i] = ""
        }
        self.day = day
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
        self.yearMonthDay = Int((String(year)+monthString+dayString))!
    }
    
    func addTask(task:String, type:String, hour:Int){
        tasks[hour] = task
        types[hour] = type
        
        
    }
    
}