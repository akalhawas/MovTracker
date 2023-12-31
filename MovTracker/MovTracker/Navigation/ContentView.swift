//
//  ContentView.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @State var safeAreaInsets: EdgeInsets = .init()

    @EnvironmentObject var model: ShareModel
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
    
    @State var isOpen = false
    @State var isOpenNoAnimation = false
    @State var show = false
    
    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            SideMenu()
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
            
            Group {
                switch selectedTab {
                    case .chat: HomeView()
                    case .search: Text("Search")
                    case .timer: Text("Timer")
                    case .bell: Text("Bell")
                    case .user: Text("User")
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            .scaleEffect(show ? 0.92 : 1)
            .ignoresSafeArea()
            
            button.view()
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: Color.theme.shadow.opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onTapGesture {
                    button.setInput("isOpen", value: isOpen)
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isOpen.toggle()
                    }
                    withAnimation {
                        isOpenNoAnimation.toggle()
                    }
                }
                .onChange(of: isOpen) { newValue in
                    if newValue {
                        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                    } else {
                        UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                    }
                }
            
            TabBar()
                .offset(y: isOpenNoAnimation ? 300 : 0)
                .offset(y: show ? 200 : 0)
//                .ignoresSafeArea()
            
        }
//        .dynamicTypeSize(.large ... .xxLarge)
    }

}

#Preview {
    ContentView()
        .environmentObject(ShareModel())
}
