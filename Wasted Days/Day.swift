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
    var types:[Int]
    var yearMonthDay:Int
    var goals:[String]
    var goalsDone:[String]
    init(year:Int, month:Int, day:Int, goals:String, goalsDone:String){
        self.year = year
        self.month = month
        tasks = []
        types = []
        for(var i = 0; i<24;i++){
            tasks[i] = "empty"
            types[i] = 7
        }
        self.day = day
        var dayString:String
        var monthString:String = ""
        
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
        self.goals = [""]
        self.goalsDone = [""]
        
    }
    init(yearMonthDay:Int){
        
        let stringDate = String(yearMonthDay)
        var splitString = Array(stringDate.characters)
        //2016.08.26
        print("here1\(splitString)")
        var yearStr = ("\(splitString[0])\(splitString[1])")
        yearStr += ("\(splitString[2])\(splitString[3])")
        self.year = Int(yearStr)!
        self.month = Int("\(splitString[4])\(splitString[5])")!
        tasks = []
        types = []
        for(var i = 0; i<24;i++){
            tasks.append("empty")
            types.append(7)
        }
        self.day = Int("\(splitString[6])\(splitString[7])")!
        
        self.yearMonthDay = yearMonthDay
        self.goals = []
        self.goalsDone = []
    }
    func addTask(task:String, type:Int, hour:Int){
        tasks[hour] = task
        types[hour] = type
        
        
    }
    func isEqual(day:Day)->Bool{
        if(self.yearMonthDay==day.yearMonthDay){
            return true
            
        }else{
            
            return false
        }
        
    }
    func setGoals(rawGoals:String){
        
        
    }
    func setGoalsDone(rawGoalsDone:String){
        
        
    }
    
}