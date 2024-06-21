//
//  Week.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct Week: Identifiable, Hashable {
    let days: [Day]

    var id: String {
        days.first { $0.weekDay == .mon }!.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(of day: Date) {
        let components = Calendar.current.dateComponents([.day, .month, .year, .weekday], from: day)

        let sundayOfTheWeek = day.advanced(by: 60 * 60 * 24 * Double((1-components.weekday!)))
        let saturdayOfTheWeek = day.advanced(by: 60 * 60 * 24 * Double((7-components.weekday!)))

        let dates = Array(stride(from: sundayOfTheWeek, to: saturdayOfTheWeek.advanced(by: 60*60*24), by: 60*60*24))
        self.days = dates.map(Day.init)
    }

    func past() -> Week {
        Week(of: days.first!.date.addingTimeInterval(60*60*24 * -7))
    }

    func future() -> Week {
        Week(of: days.first!.date.addingTimeInterval(60*60*24 * 7))
    }
}
