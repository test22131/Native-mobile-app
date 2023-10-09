//
//  Phones.swift
//  Native3
//
//  Created by William Berggren on 2023-04-14.
//

import SwiftUI

struct PhonesView: View {
    @State private var isFullScreen = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            isFullScreen = true
        }
        .onDisappear {
            isFullScreen = false
        }
        .tabItem {
            Image(systemName: "phone.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
        .tag(1)
        .fullScreenCover(isPresented: $isFullScreen, content: {
            PhoneFullScreenView()
        })
    }
}
