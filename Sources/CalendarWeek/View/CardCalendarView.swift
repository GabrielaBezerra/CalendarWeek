//
//  CardCalendarView.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct CardCalendarView<Model: CalendarModel, CardContent: View, EmptyCardContent: View>: View {

    @Environment(CalendarViewModel<Model>.self) var viewModel: CalendarViewModel

    let contentMarginsForScrollContent: Double
    @ViewBuilder var cardView: (Model) -> CardContent
    @ViewBuilder var emptyCardView: () -> EmptyCardContent

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(viewModel.selectedWeek.days, id: \.self) { day in
                    if let model = viewModel.model(for: day) {
                        cardView(model)
                    } else {
                        emptyCardView()
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(contentMarginsForScrollContent, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollPosition(id: $viewModel.selectedDay)
        .animation(.easeInOut, value: viewModel.selectedDay)
    }
}
