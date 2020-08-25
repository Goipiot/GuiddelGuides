//
//  Date+Extension.swift
//  Guiddel
//
//  Created by Anton Danilov on 03.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//
import Foundation

extension Date {
    
    var startOfWeek: Date {
        let calendar = Calendar(identifier: .iso8601)
        let monday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return monday.addDaysToDate(days: 1)
    }
    
    var endOfWeek: Date {
        let calendar = Calendar(identifier: .iso8601)
        let monday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return monday.addDaysToDate(days: 7)
    }
    
    func startOfMonth() -> Date {
        let date = Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month],
                                                  from: Calendar.current.startOfDay(for: self)))!
        return date.addDaysToDate(days: 1)
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func dayNumberOfWeek() -> Int {
        var number = Calendar(identifier: .iso8601).dateComponents([.weekday], from: self).weekday!
        if number == 7 {
            number = 1
        } else if number == 1 {
            number = 7
        } else {
            number -= 1
        }
        return number
    }
    
    func getNumberOfDaysInMonth() -> Int {
        let range = Calendar(identifier: .iso8601).range(of: .day, in: .month, for: self)!
        let numDays = range.count
        return numDays
    }
    
    func isInThisMonth() -> Bool {
        return Calendar(identifier: .iso8601).isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    func addDaysToDate(days: Int) -> Date {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func toDate(format: String) -> String {
        let formatter = DateFormatter.get(with: .full)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getNumberOfMinutes() -> Int {
        let hours = Calendar(identifier: .gregorian).component(.hour, from: self)
        let minutes = Calendar(identifier: .gregorian).component(.minute, from: self)
        let numberOfMinutes = hours * 60 + minutes
        return numberOfMinutes
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        print(date)
        
        while date <= toDate {
            dates.append(date)
            let calendar = Calendar.current
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

