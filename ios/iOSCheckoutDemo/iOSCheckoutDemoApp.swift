//
//  iOSCheckoutDemoApp.swift
//  iOSCheckoutDemo
//
//  Created by FLP2ZakiIbrahim on 14/04/25.
//

import SwiftUI

@main
struct iOSCheckoutDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CartManager())
        }
    }
}
