//
//  kioskApp.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/9/26.
//

import SwiftUI

@main
struct kioskApp: App {
    // Manages tracking and streaming of MDM updates
    @State private var configManager = AppConfigManager()

    var body: some Scene {
        WindowGroup {
            Group {
                if let validURL = configManager.activeURL {
                    KioskView(url: validURL) // Render kiosk for a valid URL
                } else {
                    MissingConfigView() // Show missing config for an invalid URL
                }
            }
            .statusBarHidden(true)
            .environment(configManager)
            .task {
                // On app launch, start listening for live MDM configuration updates
                await configManager.listenForMDMUpdates()
            }
        }
    }
}
