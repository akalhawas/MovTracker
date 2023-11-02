//
//  TabBar.swift
//  MovTracker
//
//  Created by ali alhawas on 17/04/1445 AH.
//

import SwiftUI

struct TabBar: View {
    @State var color: Color = .secondary
    @State var selectedX: CGFloat = 0
    @State var x: [CGFloat] = [0, 0, 0, 0, 0]
    
    @EnvironmentObject var model: ShareModel
    @State var selectedTab: Tab = .chat
    @Environment (\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0
            
            HStack {
                content
            }
            .padding(.bottom, hasHomeIndicator ? 16 : 0)
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 88 : 49)
            .background( MaterialEffect(style: .systemUltraThinMaterial)
//                colorScheme == .dark
//                ? MaterialEffect(style: .systemUltraThinMaterial)
//                : MaterialEffect(style: .systemChromeMaterialDark)
            )
            .background(
                Circle()
                    .fill(color)
                    .offset(x: selectedX, y: -10)
                    .frame(width: 88)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
            .overlay(
                Rectangle()
                    .frame(width: 28, height: 5)
                    .cornerRadius(3)
                    .frame(width: 88)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: selectedX)
                    .blendMode(.overlay)
            )
            .backgroundStyle(cornerRadius: hasHomeIndicator ? 34 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .offset(y: model.showTab ? 0 : 200)
            .accessibility(hidden: !model.showTab)
        }
    }
    
    var content: some View {
        ForEach(Array(tabItems.enumerated()), id: \.offset) { index, tab in
            if index == 0 { Spacer() }
            
            Button {
               tab.icon.setInput("active", value: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    tab.icon.setInput("active", value: false)
                }
                
                withAnimation(.tabSelection) {
                    selectedTab = tab.selectedTab
                    selectedX = x[index]
                    color = tab.color
                }
            } label: {
                VStack(spacing: 0) {
                    tab.icon.view()
                        .frame(height: 36)
                        .opacity(selectedTab == tab.selectedTab ? 1 : 0.5)
                    Text(tab.name).font(.caption2)
                        .frame(width: 88)
                        .lineLimit(1)
                }
                .overlay(
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .global).minX
//                        let _ = print("offset = \(offset)")
                        Color.clear
                            .preference(key: TabPreferenceKey.self, value: offset)
                            .onPreferenceChange(TabPreferenceKey.self) { value in
                                x[index] = value
                                if selectedTab == tab.selectedTab {
                                    selectedX = x[index]
                                }
                            }
                    }
                )
            }
            .frame(width: 44)
            .foregroundColor(selectedTab == tab.selectedTab ? .primary : .secondary)
//            .blendMode(selectedTab == tab.selectedTab ? .overlay : .normal)
            
            Spacer()
        }
    }
}

#Preview {
    TabBar()
        .environmentObject(ShareModel())
}
