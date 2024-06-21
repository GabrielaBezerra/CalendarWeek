//
//  WeekDay.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation

public enum WeekDay: Int, CaseIterable {
    case sun, mon, tue, wed, thu, fri, sat

    public var description: String {
        DateFormatter().shortWeekdaySymbols[self.rawValue]
    }

    public init(_ number: Int?) {
        self.init(rawValue: number! - 1)!
    }
}
