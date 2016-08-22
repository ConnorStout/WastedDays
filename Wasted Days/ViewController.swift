//
//  ViewController.swift
//  Wasted Days
//
//  Created by Connor Stout on 7/4/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet var dailyTimeTable: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        print("here")
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeCell
        cell.colorDez.backgroundColor? = UIColor.blueColor()
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
        print(labelString);
        
        cell.timeLabel.text = labelString
        
        return cell
        
        
    }


}

