//
//  ViewController.swift
//  TimeForTimeZone
//
//  Created by roberto rojas on 1/14/15.
//  Copyright (c) 2015 CocuyoStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var timeZonePicker: UIPickerView!
    @IBOutlet weak var dateTimeZoneLabel: UILabel!
    @IBOutlet weak var timeTimeZoneLable: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    
    var timeZoneNames = [AnyObject]()
    var timeZones     = [AnyObject]()
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateTimeZones()
        displayTimeZoneForSelectedRow(0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func populateTimeZones() {
        let abbreviationDictionary = NSTimeZone.abbreviationDictionary()
        //println("available timeZones: \(abbreviationDictionary.count)")
        for (timeZoneName,timeZone) in abbreviationDictionary {
            timeZones.append(timeZone)
            timeZoneNames.append(timeZoneName)
        }
    }
    
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeZones.count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 54.0
    }
    
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
//        
//        var outputView = view
//        
//        if (outputView == nil) {
//        
//            outputView = UIView()
//            outputView.backgroundColor = UIColor.clearColor()
//            var label = UILabel()
//            label.backgroundColor = UIColor.whiteColor()
//            outputView.addSubview(label)
//        }
//        
//        return outputView
//        
//        
//    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        
        let title = NSMutableAttributedString(string: "\(timeZones[row])", attributes: nil)
        return title
     
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayTimeZoneForSelectedRow(row)
    }
    
    func displayTimeZoneForSelectedRow(row: Int) {
        let now = NSDate()
        let timeZoneName = timeZoneNames[row] as String
        
        dateTimeZoneLabel.text = extractDate(now, timeZoneName: timeZoneName)
        timeTimeZoneLable.text = extractTime(now, timeZoneName: timeZoneName)
        timeZoneLabel.text     = extractTimeZoneName(now, timeZoneName: timeZoneName)
        
    }
    
    func extractDate(theDate: NSDate, timeZoneName: String) -> String {
        
        dateFormatter.timeStyle =  NSDateFormatterStyle.NoStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeZone  = NSTimeZone(abbreviation: timeZoneName)
        let timeZoneStr:String  = "\(dateFormatter.stringFromDate(theDate))"

        return timeZoneStr
        
    }
    
    func extractTime(theDate: NSDate, timeZoneName: String) -> String {
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeZone  = NSTimeZone(abbreviation: timeZoneName)
        let timeZoneStr:String  = "\(dateFormatter.stringFromDate(theDate))"
        
        return timeZoneStr
    }
    
    func extractTimeZoneName(theDate: NSDate, timeZoneName: String) -> String {
        let timeZone = NSTimeZone(abbreviation: timeZoneName)
        
        return timeZone?.name ?? "No TZ"
    }


}

