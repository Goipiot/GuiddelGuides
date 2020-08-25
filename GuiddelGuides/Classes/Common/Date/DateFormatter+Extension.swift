//
//  DateFormatter+Extension.swift
//  Guiddel
//
//  Created by Anton Danilov on 03.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

enum DateFormat {
    case day
    case week
    case longMonthDay
    case monthDay
    case full
    case calendar
    case fullWithTime
    case timeOnly
}

extension DateFormatter {

    static func get(with format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        switch format {
        case .day:
            formatter.dateFormat =  "dd"
        case .week:
            formatter.dateFormat =  "EEEE"
        case .longMonthDay:
            formatter.dateFormat =  "dd MMMM"
        case .monthDay:
            formatter.dateFormat =  "MM.dd"
        case .full:
            formatter.dateFormat =  "MM-dd-yyyy"
        case .calendar:
            formatter.dateFormat =  "MMMM, yyyy"
        case .fullWithTime:
            formatter.dateFormat =  "MM-dd-yyyy HH:mm"
        case .timeOnly:
            formatter.dateFormat =  "HH:mm"
        }
        return formatter
    }
}
