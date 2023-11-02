//
//  MovTrackerApp.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import SwiftUI

@main
struct MovTrackerApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var model = ShareModel()
    
    @State private var showLaunchView: Bool = true
    @State private var showOnboardingView: Bool = true
    
    @AppStorage ("onBoarding") private var onBoarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .preferredColorScheme(model.selectedScheme)
                    .environmentObject(model)

                
                ZStack {
                    if showOnboardingView {
                        GeometryReader { proxy in
                            let size = proxy.size
                            OnBoardingView(screenSize: size, showOnboardingView: $showOnboardingView)
                        }
                        .transition(.opacity)
                        .preferredColorScheme(model.selectedScheme)
                    }
                }
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .trailing))
                            .preferredColorScheme(model.selectedScheme)
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("API = \(ConfigrationManager.environment)")
        print("URL = \(API.baseURL)")
        return true
    }
}
