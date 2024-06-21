//
//  Day.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation

public struct Day: Identifiable, Equatable, Hashable {
    public let id: String
    public let number: Int
    public let month: String
    public let year: String
    public let weekDay: WeekDay
    public let date: Date

    var isWeekend: Bool {
        weekDay == .sun || weekDay == .sat
    }

    var isToday: Bool {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        return components.day == number &&
        DateFormatter().monthSymbols[components.month! - 1] == month &&
        components.year == Int(year)!
    }

    public init(from date: Date) {
        let components = Calendar.current.dateComponents([.weekday, .day, .month, .year], from: date)
        let weekDay = WeekDay(components.weekday)
        let day = components.day!
        let month = DateFormatter().monthSymbols[components.month! - 1]
        let year = "\(components.year!)"
        self.id = "\(day)/\(weekDay.description)/\(month)/\(year)"
        self.weekDay = weekDay
        self.number = day
        self.month = month
        self.year = year
        self.date = date
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.number == rhs.number && lhs.weekDay == rhs.weekDay
    }

}
