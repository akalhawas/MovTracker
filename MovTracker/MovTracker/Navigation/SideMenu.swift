//
//  SideMenu.swift
//  MovTracker
//
//  Created by ali alhawas on 17/04/1445 AH.
//

import SwiftUI
import RiveRuntime

struct SideMenu: View {
    @State var selectedMenu: SelectedMenu = .home
    @State var isDarkMode = false
//    let icon = RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person")
                    .padding(12)
                    .background(Color.white.opacity(0.2))
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text("Meng To")
                        .customFont(.body)
                    Text("UI Designer")
                        .customFont(.subheadline)
                        .opacity(0.7)
                }
                Spacer()
            }
            .padding()
            ScrollView {
                Text("BROWSE")
                    .customFont(.subheadline2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .opacity(0.7)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(menuItems) { item in
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.1)
                            .padding(.horizontal)
                        MenuRow(item: item, selectedMenu: $selectedMenu)
                    }
                }
                .padding(8)
                
                Text("HISTORY")
                    .customFont(.subheadline2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .opacity(0.7)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(menuItems2) { item in
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.1)
                            .padding(.horizontal)
                        MenuRow(item: item, selectedMenu: $selectedMenu)
                    }
                }
                .padding(8)
            }

            
            Spacer()
            
            HStack(spacing: 14) {
                menuItems3[0].icon.view()
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                    .onChange(of: isDarkMode) { newValue in
                        if newValue {
                            menuItems3[0].icon.setInput("active", value: true)
                        } else {
                            menuItems3[0].icon.setInput("active", value: false)
                        }
                    }
                Text(menuItems3[0].text)
                    .customFont(.headline)
                Toggle("", isOn: $isDarkMode)
            }
            .padding(20)
        }
        .foregroundColor(.white)
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(Color.theme.background)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SideMenu()
}
