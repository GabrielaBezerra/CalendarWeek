//
//  CalendarViewModel.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation
import Observation

@Observable
public class CalendarViewModel<Model: CalendarModel> {
    var weeks = [
        Date.now.advanced(by: 60*60*24 * -7),
        Date.now,
        Date.now.advanced(by: 60*60*24 * 7)
    ].map(Week.init(of:))

    var models: [Model]

    var selectedWeek = Week(of: .now)

    public var selectedDay: Day?

    public init(models: [Model]) {
        self.models = models
    }

    func updateWeeksBeforeAfter() {
        weeks = [
            selectedWeek.past(),
            selectedWeek,
            selectedWeek.future()
        ]
    }

    func updateSelectedDayForSelectedWeek() {
        selectedDay = selectedWeek.days[0]
    }

    public func modelExists(for day: Day) -> Bool {
        model(for: day) != nil
    }

    public func model(for day: Day) -> Model? {
        models.first { $0.day == day }
    }
}
