//
//  WeekCalendarView.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct WeekCalendarView<Model: CalendarModel, HeaderContent: View, DayContent: View, WeekBackgroundContent: View>: View {

    @Environment(CalendarViewModel<Model>.self) var viewModel

    let daySpacing: Double
    @ViewBuilder var headerView: (Day) -> HeaderContent
    @ViewBuilder var dayView: (Day) -> DayContent
    @ViewBuilder var weekBackground: () -> WeekBackgroundContent

    init(
        daySpacing: Double,
        headerView: @escaping (Day) -> HeaderContent,
        dayView: @escaping (Day) -> DayContent,
        weekBackground: @escaping () -> WeekBackgroundContent
    ) {
        self.daySpacing = daySpacing
        self.headerView = headerView
        self.dayView = dayView
        self.weekBackground = weekBackground
    }

    var body: some View {
        @Bindable var viewModel = viewModel


        VStack {

            // TODO: Mudar View do Mês e Ano
            if let day = viewModel.selectedDay {
                headerView(day)
            }

            TabView(selection: $viewModel.selectedWeek) {
                ForEach(viewModel.weeks) { week in
                    HStack(spacing: daySpacing) {
                        ForEach(week.days) { day in

                            // TODO: Mudar View do Dia
                            dayView(day)
                                .onTapGesture {
                                    viewModel.selectedDay = day
                                }
                        }
                        .animation(.snappy, value: viewModel.selectedWeek)
                    }
                    .tag(week)
                    .padding()
                    .background(weekBackground())
                }
            }
            .containerRelativeFrame([.horizontal])
            .containerRelativeFrame([.vertical], count: 100, span: 10, spacing: 0)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }

}
