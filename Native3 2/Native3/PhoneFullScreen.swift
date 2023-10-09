//
//  PhoneFullScreen.swift
//  Native3
//
//  Created by William Berggren on 2023-04-24.
//


import SwiftUI

struct PhoneFullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedTab = 4
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CameraAndGalleryView()
            PhoneContacts()
            PhoneInCall()
        }
        .accentColor(.black)
        .fontWeight(.bold)
        .onChange(of: selectedTab) { newTab in
            if newTab == 5 {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                })
            }
        }
    }
}

