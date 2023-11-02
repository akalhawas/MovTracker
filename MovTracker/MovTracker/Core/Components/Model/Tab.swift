//
//  Tab.swift
//  MovTracker
//
//  Created by ali alhawas on 17/04/1445 AH.
//

import SwiftUI
import RiveRuntime

//struct TabItem: Identifiable {
//    let id = UUID()
//    var name: String
//    var icon: String
//    var color: Color
//    var selection: Tab
//}
//
//var tabItems = [
//    TabItem(name: "Learn Now", icon: "house", color: .red, selection: .home),
//    TabItem(name: "Explore", icon: "magnifyingglass", color: .blue, selection: .explore),
//    TabItem(name: "Notifications", icon: "bell", color: .red, selection: .notifications),
//    TabItem(name: "Library", icon: "rectangle.stack", color: .pink, selection: .library)
//]
//
//enum Tab: String {
//    case home
//    case explore
//    case notifications
//    case library
//}

struct TabItem: Identifiable {
    var id = UUID()
    var name: String
    var icon: RiveViewModel
    var color: Color
    var selectedTab: Tab
}

var tabItems = [
    TabItem(name: "Chat", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), color: .secondary, selectedTab: .chat),
    TabItem(name: "Search", icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), color: .secondary, selectedTab: .search),
    TabItem(name: "Timer", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), color: .secondary, selectedTab: .timer),
    TabItem(name: "Bell", icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), color: .secondary, selectedTab: .bell),
    TabItem(name: "User", icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), color: .secondary, selectedTab: .user)
]

enum Tab: String {
    case chat
    case search
    case timer
    case bell
    case user
}
