//
//  ViewController.swift
//  PlayingWithDates
//
//  Created by roberto rojas on 1/14/15.
//  Copyright (c) 2015 CocuyoStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle =  NSDateFormatterStyle.MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        let usLocale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.locale = usLocale
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        let nowStr = "\(dateFormatter.stringFromDate(now))"
        
        dateLbl.text = "\(nowStr)"
        
        let localIdentifiers = NSLocale.availableLocaleIdentifiers() as [String]
        
        //for localId in localIdentifiers {
           
          //  let currentLocale = NSLocale(localeIdentifier: localId)
          //  dateFormatter.locale = currentLocale
            //println("\(localId): \(dateFormatter.stringFromDate(now))")
          //  println("\(localId): \(now.descriptionWithLocale(currentLocale))")
        //}
        
        let abbreviationDictionary = NSTimeZone.abbreviationDictionary()
        println("count: \(abbreviationDictionary.count)")
        for (timeZoneName,timezone) in abbreviationDictionary {
            dateFormatter.timeZone = NSTimeZone(abbreviation: timeZoneName as String)
            println("\(timezone): \(dateFormatter.stringFromDate(now))")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

