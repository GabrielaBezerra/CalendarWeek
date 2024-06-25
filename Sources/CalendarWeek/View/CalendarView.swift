//
//  CalendarView.swift
//  ShowUpp
//
//  Created by Gabriela Bezerra on 28/05/24.
//  Copyright © 2024 Apple Developer Academy IFCE. All rights reserved.
//

import Foundation
import SwiftUI

public struct CalendarView<Model: CalendarModel, HeaderContent: View, DayContent: View, WeekBackgroundContent: View, ModelContent: View, EmptyStateModelContent: View>: View {

    @Environment(CalendarViewModel<Model>.self) var viewModel: CalendarViewModel<Model>

    public let daySpacing: Double
    public let contentMargins: Double
    @ViewBuilder public var headerView: (Day) -> HeaderContent
    @ViewBuilder public var dayView: (Day) -> DayContent
    @ViewBuilder public var weekBackground: () -> WeekBackgroundContent
    @ViewBuilder public var dayContentView: (Model) -> ModelContent
    @ViewBuilder public var dayEmptyStateView: () -> EmptyStateModelContent

    /// View with calendar, weekly perspective, and internal content linked to each date
    /// - Parameters:
    ///   - models: Array with model linked to each date. Model must conform to `CalendarModel` protocol
    ///   - daySpacing: Spacing between days of the week views
    ///   - headerView: View that will be shown above the week view. If you want to remove it, use EmptyView()
    ///   - dayView: View that shows number and day of the week
    ///   - weekBackground: Background of the week view
    ///   - cardView: View that shows model information for the selected day
    ///   - emptyCardView: View with empty state if there is no model for the selected day
    public init(
        contentMargins: Double,
        weekDaySpacing: Double,
        headerView: @escaping (Day) -> HeaderContent,
        weekDayView: @escaping (Day) -> DayContent,
        weekBackground: @escaping () -> WeekBackgroundContent,
        dayContentView: @escaping (Model) -> ModelContent,
        dayEmptyStateView: @escaping () -> EmptyStateModelContent
    ) {
        self.daySpacing = weekDaySpacing
        self.headerView = headerView
        self.dayView = weekDayView
        self.weekBackground = weekBackground
        self.dayContentView = dayContentView
        self.dayEmptyStateView = dayEmptyStateView
        self.contentMargins = contentMargins
    }

    public var body: some View {
        VStack {
            WeekCalendarView<Model, HeaderContent, DayContent, WeekBackgroundContent>(
                daySpacing: daySpacing,
                headerView: headerView,
                dayView: dayView,
                weekBackground: weekBackground
            )
            CardCalendarView<Model, ModelContent, EmptyStateModelContent>(
                contentMarginsForScrollContent: contentMargins,
                cardView: dayContentView,
                emptyCardView: dayEmptyStateView
            )
        }
        .environment(viewModel)
        .onAppear {
            viewModel.selectedDay = Day(from: .now)
        }
        .onChange(of: viewModel.selectedWeek) { _, _ in
            viewModel.updateSelectedDayForSelectedWeek()
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { gesture in
                    viewModel.updateWeeksBeforeAfter()
                }
        )
    }

}
