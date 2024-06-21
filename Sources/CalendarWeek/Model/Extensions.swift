//
//  Extensions.swift
//  SwiftUI-iOS
//
//  Created by Gabriela Bezerra on 21/06/24.
//  Copyright © 2024 Gabriela Bezerra. All rights reserved.
//

import Foundation

extension Int {
    var descriptionWithZero: String {
        if self >= 0 {
            return self > 9 ? "\(self)" : "0\(self)"
        } else {
            return self < -9 ? "-\(self * -1)" : "-0\(self * -1)"
        }
    }
}
