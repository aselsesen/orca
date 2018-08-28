//
//  CalendarVars.swift
//  orcakurekk
//
//  Created by Asel Şeşen on 29.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import Foundation


let date = NSDate()
let calendar = NSCalendar.currentCalendar()
let day = calendar.component(NSCalendarUnit.Day, fromDate: date)
let weekday = calendar.component(NSCalendarUnit.Weekday, fromDate: date)
let month = calendar.component(NSCalendarUnit.Month, fromDate: date) - 1
let year = calendar.component(NSCalendarUnit.Year, fromDate: date)

let todaysMonth = calendar.component(NSCalendarUnit.Month, fromDate: date)

var mondaysDate: NSDate {
    let iso8601 =  NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
    return iso8601.dateFromComponents(iso8601.components([.YearForWeekOfYear, .WeekOfYear], fromDate: NSDate()))!
}


extension NSDate {
    var yesterday: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day , value: -1 , toDate: date, options: [])!
    }
    
    var tomorrow: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: date, options: [])!
    }
    
    
    var twoDaysLater: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 2, toDate: date, options: [])!
    }
    
    var threeDaysLater: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 3, toDate: date, options: [])!
    }
    
    var fourDaysLater: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 4, toDate: date, options: [])!
    }
    
    
    var fiveDaysLater: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 5, toDate: date, options: [])!
    }
    
    
    var sixDaysLater: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 6, toDate: date, options: [])!
    }
    
    var twoDaysBefore: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -2, toDate: date, options: [])!
    }
    
    var threeDaysBefore: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -3, toDate: date, options: [])!
    }
    
    
    var fourDaysBefore: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -4, toDate: date, options: [])!
    }
    
    var fiveDaysBefore: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -5, toDate: date, options: [])!
    }
    
    
    var sixDaysBefore: NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -6, toDate: date, options: [])!
    }
    
    
}