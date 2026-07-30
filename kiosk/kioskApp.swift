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
                // Choose a view according to the configuration status
                switch configManager.status {
                    case .pending:
                        ProgressView()
                    case .configured(let url):
                        KioskView(url: url)
                    case .unconfigured:
                        MissingConfigView()
                }
            }
            .background(Color(.systemBackground))
            .persistentSystemOverlays(.hidden)
            .defersSystemGestures(on: .all)
            .ignoresSafeArea()
            .statusBarHidden(true)
            .task {
                // On app launch, start listening for live MDM configuration updates
                await configManager.listenForMDMUpdates()
            }
        }
    }
}
