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
    @IBOutlet weak var timeForTimeZoneLabel: UILabel!
    
    var timeZoneNames = [AnyObject]()
    var timeZones     = [AnyObject]()
    
    
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
        println("available timeZones: \(abbreviationDictionary.count)")
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
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let title = NSMutableAttributedString(string: "\(timeZones[row])", attributes: nil)
        
        return title
     
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayTimeZoneForSelectedRow(row)
    }
    
    func displayTimeZoneForSelectedRow(row: Int) {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle =  NSDateFormatterStyle.FullStyle
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeZone = NSTimeZone(abbreviation: timeZoneNames[row] as String)
        
        timeForTimeZoneLabel.text = "\(dateFormatter.stringFromDate(now))"
    }


}

