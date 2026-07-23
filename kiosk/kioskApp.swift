//
//  kioskApp.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/9/26.
//

import SwiftUI

@main
struct kioskApp: App {
    @State private var configManager = AppConfigManager()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            Group {
                if let validURL = URL(string: configManager.activeURLString) {
                    KioskView(url: validURL).environment(configManager).statusBarHidden(true)
                }
            }
            .onChange(of: scenePhase) { _, newPhase in
                if newPhase == .active {
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
}
