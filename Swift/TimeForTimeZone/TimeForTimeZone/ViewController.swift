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
    var backgroundImageView:UIImageView?
    
    var timeZoneNames = [AnyObject]()
    var timeZones     = [AnyObject]()
    let dateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateTimeZones()
        displayTimeZoneForSelectedRow(0)
        setupBgImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBgImage() {
        let background = UIImage(named: "TimeZoneBackground")
        self.backgroundImageView = UIImageView(image: background!)
        var bgImageViewFrame = self.backgroundImageView!.frame
        bgImageViewFrame.size.width = self.view.bounds.size.width
        bgImageViewFrame.size.height = self.view.bounds.size.height
        self.backgroundImageView!.frame = bgImageViewFrame
        self.backgroundImageView!.layer.zPosition = -1
        self.backgroundImageView!.contentMode = UIViewContentMode.ScaleAspectFill;
        self.view.addSubview(self.backgroundImageView!)
    }
    
    
    func populateTimeZones() {
        let abbreviationDictionary = NSTimeZone.abbreviationDictionary()
        for (timeZoneName,timeZone) in abbreviationDictionary {
            timeZones.append(timeZone)
            timeZoneNames.append(timeZoneName)
        }
    }
    
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeZones.count
    }
    
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        var pickerLabel = view as UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            let titleData = timeZones[row] as String
            let pickerLabelTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next Demi Bold", size: 20.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
            pickerLabel.attributedText = pickerLabelTitle
            
            //color  and center the label's background
            let hue = CGFloat(row)/CGFloat(timeZoneNames.count)
            pickerLabel.backgroundColor = UIColor.clearColor()
            pickerLabel.textAlignment = .Center
        }
        
        return pickerLabel
    }
    
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let title = NSMutableAttributedString(string: "\(timeZones[row])", attributes: nil)
        return title
     
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayTimeZoneForSelectedRow(row)
    }
    
    
    // MARK: Helper Methods
    
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

