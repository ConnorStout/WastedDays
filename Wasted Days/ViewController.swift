//
//  ViewController.swift
//  Wasted Days
//
//  Created by Connor Stout on 7/4/16.
//  Copyright © 2016 Connor Stout. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var currYearMonthDay:Int = 0
    var currIndex:Int = 0
    var changeViewOut = false
    var currChangeType: ChangeTypeView = ChangeTypeView()
    var df:DateFormatter = DateFormatter()
    var c = ColorObject()
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeCollection: UICollectionView!
    var inset:CGFloat = 0
    var verticalInset:CGFloat = 0
    
    override func viewDidLoad() {
        if(currYearMonthDay == 0){
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            currYearMonthDay = df.getCurrYearMonthDay()
            currIndex = df.getDayIndex(currYearMonthDay)
            df.possiblyAddNewDay(currYearMonthDay)
            currIndex = df.getDayIndex(currYearMonthDay)
            updateLabel()
            print(appDelegate.allDays[currIndex].types)
            updateLabel()
            self.view.backgroundColor = UIColor(red: 142/255, green: 237/255, blue: 255/255, alpha: 1.0)
            inset = self.view.frame.width/50
            timeCollection?.contentInset = UIEdgeInsets(top: inset,left: inset*2,bottom: inset,right: inset*2)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 12
            
            timeCollection?.collectionViewLayout = layout
        }
        
        
        super.viewDidLoad()
      
        
        
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
    
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TimeCell
        
        
   
        cell.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0)
        cell.layer.cornerRadius = 6;
        var currTime = indexPath.row
        var labelString:String = ""
        if(currTime==0){
            labelString = "12 AM"
            
        }else if (currTime<12){
            labelString = "\(currTime)"
            currTime+=1
        }else if (currTime == 12){
            labelString = "12 PM"
        }
        else{
            labelString = "\(currTime-12)"
        }
        
        
        cell.timeLabel.text = labelString
        cell.timeLabel.textColor = UIColor.white
        //task
        
        cell.tag = indexPath.row
        
        
        //cat
        let color:Int = appDelegate.allDays[currIndex].types[indexPath.row]
        
        cell.backgroundColor? = getColor(color)
      
        
        
        let pressed = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressed(_:)))
        
        cell.addGestureRecognizer(pressed)
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/4-(inset*3), height: self.view.frame.width/4-(inset*3))
    }
    
    
    
   

    

    
    
    
    
    
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeCell
        //time label
        cell.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0)
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
    */

    @IBAction func leftButton(_ sender: AnyObject) {
        currYearMonthDay = df.previousDay(currYearMonthDay);
        df.possiblyAddNewDay(currYearMonthDay)
        currIndex = df.getDayIndex(currYearMonthDay)
        timeCollection.reloadData()
        updateLabel()
        print(appDelegate.allDays[currIndex].types)
    }
    
    
    @IBAction func rightButton(_ sender: AnyObject) {
        currYearMonthDay = df.nextDay(currYearMonthDay)
        df.possiblyAddNewDay(currYearMonthDay)
        currIndex = df.getDayIndex(currYearMonthDay)
        timeCollection.reloadData()
        updateLabel()
        timeCollection.reloadData()
        
    }
    
   
    func updateLabel(){
        let labelString:String = ("\(appDelegate.allDays[currIndex].month)/\(appDelegate.allDays[currIndex].day)/\(appDelegate.allDays[currIndex].year)")
        

        dateLabel?.text = labelString
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        appDelegate.allDays[currIndex].tasks[Int(textField.tag)] = textField.text!
    }
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer)
    {

        
        if(!self.view.subviews.contains(currChangeType)){
            let newChangeView = (ChangeTypeView(frame: self.view.frame,sender: sender.view!,currIndex:currIndex))
            
            currChangeType = newChangeView
            view.addSubview(newChangeView)
           
            changeViewOut = true
            
        }
        
    }
  

    func getColor(_ a:Int)->UIColor{
        let colorScheme = ColorObject()
        return colorScheme.pieArray()[a]
        
    }
    
    func getNumberFromColor(_ a:UIColor)->Int{
        
        let c = ColorObject()
        return c.getNumber(a)
    }

    
}

