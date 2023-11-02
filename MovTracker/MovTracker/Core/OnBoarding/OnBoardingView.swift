//
//  OnBoardingView.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import SwiftUI

struct OnBoardingView: View {
    @State var offset: CGFloat = 0
    var screenSize: CGSize
    
    @Binding var showOnboardingView: Bool
    
//    @AppStorage ("onBoarding") private var onBoarding: Bool = true

    var body: some View {
        ZStack {
            Color.onboarding.background.ignoresSafeArea()
            
            VStack {
                OffsetPageTabView(offset: $offset) {
                    HStack(spacing: 0) {
                        ForEach(onboardingItems) { intro in
                            VStack {
                                Image(intro.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: screenSize.height / 3)
                                
                                VStack(alignment: .leading, spacing: 22) {
                                    Text(intro.title)
                                        .font(.largeTitle.bold())
                                    Text(intro.description)
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(Color.onboarding.accent)
                                .padding(.top, 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            // Setting max width
                            .frame(width: screenSize.width, height: screenSize.height)
                            .background(Color.onboarding.background.ignoresSafeArea())
                        }
                    }
                }
                
                // Animated Indicator
                HStack(alignment: .bottom) {
                    
                    // Indicators
                    HStack(spacing: 12) {
                        ForEach(onboardingItems.indices, id: \.self) { index in
                            Capsule()
                                .fill(Color.onboarding.accent)
                            // increasing width for only current index ...
                                .frame(width: getIndex() == index ? 20 : 7, height: 7)
                        }
                    }
                    .overlay(
                        Capsule()
                            .fill(Color.onboarding.accent)
                            .frame(width: 20, height: 7)
                            .offset(x: getIndicatorsOffset())
                        
                        , alignment: .leading)
                    .offset(x: 10, y: -15)
                    
                    Spacer()
                    
                    Button {
                        if onboardingItems[getIndex()] != onboardingItems.last {
                            // updating offset ...
                            let index = min(getIndex() + 1, onboardingItems.count - 1)
                            offset = CGFloat(index) * screenSize.width
                        } else {
                            print("DEBUG: pressing the last")
                            withAnimation(.spring()) {
                                showOnboardingView = false
    //                            onBoarding = false
                            }
                        }
                        
                    } label: {
                        Image(systemName: onboardingItems[getIndex()] == onboardingItems.last ? "chevron.left" : "chevron.right")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(20)
                            .background(
                                Circle()
                                    .fill(onboardingItems[getIndex()].color)
                            )
                    }
                }
                .padding()
                .offset(y: -20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // Animating when index changes ...
            .animation(.easeInOut, value: getIndex())
        }
    }
    
    // Expanding index based on offset ..
    func getIndicatorsOffset() -> CGFloat {
        let progress = offset / screenSize.width
        
        // 12 = spacing
        // 7 = Circle size ...
        let maxWidth:CGFloat = 12 + 7
        
        return progress * maxWidth
    }
    
    // Expanding index based on offset ..
    func getIndex() -> Int {
        let progress = round(offset / screenSize.width)
        
        // For saftey ..
        let index = min(Int(progress), onboardingItems.count - 1)
        return index
    }
}

#Preview {
    GeometryReader { proxy in
        let size = proxy.size
        OnBoardingView(screenSize: size, showOnboardingView: .constant(true))
            .preferredColorScheme(.dark)
    }
}


struct OnBoarding: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var color: Color
}

var onboardingItems: [OnBoarding] = [
    OnBoarding(image: "image1", title: "Chose your favourate menu", description: "But they are not the inconvenience that our oleasure", color: .blue),
    OnBoarding(image: "image2", title: "Chose your favourate menu", description: "But they are not the inconvenience that our oleasure", color: .red),
    OnBoarding(image: "image3", title: "Chose your favourate menu", description: "But they are not the inconvenience that our oleasure", color: .green),
    OnBoarding(image: "image4", title: "Chose your favourate menu", description: "But they are not the inconvenience that our oleasure", color: .green),
    OnBoarding(image: "image5", title: "Chose your favourate menu", description: "But they are not the inconvenience that our oleasure", color: .green),
]
