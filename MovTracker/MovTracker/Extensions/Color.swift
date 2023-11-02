//
//  Color.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch  = LaunchTheme()
    static let onboarding  = OnboardingTheme()
}

struct ColorTheme {
    
    let accent = Color("MovAccentColor")
    let background = Color("MovBackgroundColor")
    let green = Color("MovGreenColor")
    let red = Color("MovRedColor")
    let secondaryText = Color("MovSecondaryTextColor")
    let shadow = Color("MovShadowColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}

struct OnboardingTheme {
    let accent = Color("OnboardingAccentColor")
    let background = Color("OnboardingBackgroundColor")
}
