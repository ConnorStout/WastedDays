//
//  MyAxisFormatter.swift
//  Wasted Days
//
//  Created by Connor Stout on 12/27/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//
import Charts
import Foundation
class MyAxisFormatter: NSObject, IAxisValueFormatter {
    var values:[String]
    init(axis:[String]) {
        values = axis
    }
    override init(){
        values = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
        super.init()

    }
   
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: values[Int(value)])
    }
}
