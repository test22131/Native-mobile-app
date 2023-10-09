//
//  Native3App.swift
//  Native3
//
//  Created by William Berggren on 2023-04-14.
//

import SwiftUI

@main
struct NativeApp: App {
    @StateObject private var callStatus = CallStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(callStatus)
        }
    }
}
