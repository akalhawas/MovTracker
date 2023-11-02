//
//  ShareModel.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import SwiftUI
import Combine

class ShareModel: ObservableObject {
    
    // Tab Bar
    @Published var showTab: Bool = true
    
    // Navigation Bar
    @Published var showNav: Bool = true
    
    // Modal
    @Published var showModal: Bool = false
    @Published var dismissModal: Bool = false
    
    // Detail View
    @Published var showDetail: Bool = false
    @Published var selectedCourse: Int = 0
        
    @AppStorage ("systemThemeVal") var systemTheme: Int = SchemeType.allCases.first!.rawValue
    var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        
        switch theme {
            case .light: return .light
            case .dark: return .dark
            default: return nil
        }
        
    }
}

enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    case system, light, dark
}

extension SchemeType {
    var title: String {
        switch self {
            case .system: return "System"
            case .light: return "Light"
            case .dark: return "Dark"
        }
    }
}
